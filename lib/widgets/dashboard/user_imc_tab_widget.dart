import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/services/imc/bloc/imc_bloc.dart';
import 'package:imc_project_app/utils/date_utils.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/date_filter_widget.dart';
import 'package:imc_project_app/widgets/default_table.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserImcTab extends StatefulWidget {
  const UserImcTab({
    super.key,
  });

  @override
  State<UserImcTab> createState() => _UserImcTabState();
}

class _UserImcTabState extends State<UserImcTab> {
  Future<List<dynamic>> getImcData() async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      return [];
    }

    final response = await supabase.from('user_imc').select('createdAt,imc').eq(
          'userId',
          userId,
        );

    final formattedDateResponse = response.map((item) {
      final createdAt = formatDate(item['createdAt']);

      return {
        'createdAt': createdAt,
        'imc': item['imc'],
      };
    }).toList();

    return formattedDateResponse;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImcBloc, ImcState>(
      builder: (context, state) {
        if (state is ImcLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.imc);
                    },
                    label: 'Registrar Índice de Masa Corporal',
                  ),
                  const SizedBox(height: 20),
                  _buildDatePicker(),
                  const SizedBox(height: 20),
                  Container(
                    height: 300,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: FutureBuilder<List<dynamic>>(
                            future: getImcData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final imcData = snapshot.data!;

                                imcData.sort(
                                  (a, b) => DateFormat('dd-MM-yyyy')
                                      .parse(a['createdAt'])
                                      .compareTo(
                                        DateFormat('dd-MM-yyyy')
                                            .parse(b['createdAt']),
                                      ),
                                );

                                final currentDate = DateTime.now();
                                final firstDayOfMonth = DateTime(
                                  currentDate.year,
                                  currentDate.month,
                                  1,
                                );

                                final lastDayOfMonth = DateTime(
                                  currentDate.year,
                                  currentDate.month + 1,
                                  0,
                                );

                                final filteredData = imcData.where(
                                  (item) {
                                    final createdAt =
                                        DateFormat('dd-MM-yyyy').parse(
                                      item['createdAt'],
                                    );

                                    return createdAt.isAfter(
                                          firstDayOfMonth.subtract(
                                            const Duration(
                                              days: 1,
                                            ),
                                          ),
                                        ) &&
                                        createdAt.isBefore(
                                          lastDayOfMonth.add(
                                            const Duration(
                                              days: 1,
                                            ),
                                          ),
                                        );
                                  },
                                ).toList();

                                return SfCartesianChart(
                                  primaryXAxis: DateTimeAxis(
                                    dateFormat: DateFormat('dd-MM-yyyy'),
                                    labelRotation: 90,
                                  ),
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                  ),
                                  series: <ChartSeries>[
                                    LineSeries<dynamic, DateTime>(
                                      name: 'IMC',
                                      dataSource: filteredData,
                                      xValueMapper: (data, _) =>
                                          DateFormat('dd-MM-yyyy').parse(
                                        data['createdAt'],
                                      ),
                                      yValueMapper: (data, _) => data['imc'],
                                      color: Colors.purple[900],
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return const Text('Error');
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ButtonWidget(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.chartImc);
                          },
                          label: 'Ver Más',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTable(
                    title: 'Últimos IMC registrados',
                    headers: const [
                      {
                        'label': 'Altura (cm)',
                        'tooltip': 'Tu altura en centímetros',
                        'value': 'height',
                      },
                      {
                        'label': 'Peso (kg)',
                        'tooltip': 'Tu peso en kilogramos',
                        'value': 'weight',
                      },
                      {
                        'label': 'IMC',
                        'tooltip': 'Índice de Masa Corporal',
                        'value': 'imc',
                      },
                      {
                        'label': 'Fecha de registro',
                        'tooltip': 'Fecha en la que se registró el IMC',
                        'value': 'createdAt',
                      },
                    ],
                    data: state.imc,
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ImcError) {
          if (mounted) {
            return const SnackBar(
              content: Text('Un error ha ocurrido'),
            );
          }
        }

        if (state is ImcLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  DateFilterWidget _buildDatePicker() {
    return DateFilterWidget(
      onSubmit: (selectedDateRange) {
        BlocProvider.of<ImcBloc>(context).add(
          GetImcChartDataByDateFilterEvent(
            startDate: selectedDateRange.startDate!,
            endDate: selectedDateRange.endDate!,
          ),
        );
      },
    );
  }
}
