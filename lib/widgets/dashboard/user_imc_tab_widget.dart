import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/main.dart';
import 'package:imc_project_app/services/food/index.dart';
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
                  _buildDatePicker(state.filters),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _buildImcChart(
                          state.filters['filter'] as CaloriesFoodFilter,
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

  FutureBuilder<List<dynamic>> _buildImcChart(CaloriesFoodFilter filter) {
    return FutureBuilder<List<dynamic>>(
      future: getImcData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          final imcData = snapshot.data!;

          imcData.sort(
            (a, b) => DateFormat('dd-MM-yyyy').parse(a['createdAt']).compareTo(
                  DateFormat('dd-MM-yyyy').parse(
                    b['createdAt'],
                  ),
                ),
          );

          if (filter == CaloriesFoodFilter.day) {
            final imcData = snapshot.data!;
            imcData.sort(
              (a, b) =>
                  DateFormat('dd-MM-yyyy').parse(a['createdAt']).compareTo(
                        DateFormat('dd-MM-yyyy').parse(
                          b['createdAt'],
                        ),
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

            final filteredData = imcData.where((item) {
              final createdAt = DateFormat('dd-MM-yyyy').parse(
                item['createdAt'],
              );

              return createdAt.isAfter(
                    firstDayOfMonth.subtract(
                      const Duration(days: 1),
                    ),
                  ) &&
                  createdAt.isBefore(
                    lastDayOfMonth.add(
                      const Duration(days: 1),
                    ),
                  );
            }).toList();

            return SfCartesianChart(
              title: ChartTitle(text: 'Historial de IMC'),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('dd-MM-yyyy'),
                labelRotation: 90,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                LineSeries<dynamic, DateTime>(
                  name: 'IMC',
                  dataSource: filteredData,
                  xValueMapper: (data, _) => DateFormat(
                    'dd-MM-yyyy',
                  ).parse(
                    data['createdAt'],
                  ),
                  yValueMapper: (data, _) => data['imc'],
                  color: Colors.purple[900],
                ),
              ],
            );
          }

          if (filter == CaloriesFoodFilter.week) {
            final currentDate = DateTime.now();

            final weekStart = currentDate.subtract(
              Duration(days: currentDate.weekday - 1),
            );
            final weekEnd = weekStart.add(
              const Duration(days: 6),
            );

            final filteredData = imcData.where((item) {
              final createdAt = DateFormat('dd-MM-yyyy').parse(
                item['createdAt'],
              );

              return createdAt.isAfter(
                    weekStart.subtract(
                      const Duration(days: 1),
                    ),
                  ) &&
                  createdAt.isBefore(
                    weekEnd.add(
                      const Duration(days: 1),
                    ),
                  );
            }).toList();

            return SfCartesianChart(
              title: ChartTitle(text: 'Historial de IMC'),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('dd-MM-yyyy'),
                labelRotation: 90,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                LineSeries<dynamic, DateTime>(
                  name: 'IMC',
                  dataSource: filteredData,
                  xValueMapper: (data, _) => DateFormat(
                    'dd-MM-yyyy',
                  ).parse(
                    data['createdAt'],
                  ),
                  yValueMapper: (data, _) => data['imc'],
                  color: Colors.purple[900],
                ),
              ],
            );
          }

          if (filter == CaloriesFoodFilter.month) {
            final currentDate = DateTime.now();

            final firstDayOfYear = DateTime(
              currentDate.year,
              1,
              1,
            );

            final lastDayOfYear = DateTime(
              currentDate.year,
              12,
              31,
            );

            final monthlyData = <String, List<double>>{};

            for (final data in imcData) {
              final createdAt = DateFormat('dd-MM-yyyy').parse(
                data['createdAt'],
              );

              final monthYear = DateFormat('MMMM-yyyy').format(
                createdAt,
              );

              final imc = data['imc'].toDouble();

              if (createdAt.isAfter(
                    firstDayOfYear.subtract(
                      const Duration(days: 1),
                    ),
                  ) &&
                  createdAt.isBefore(
                    lastDayOfYear.add(
                      const Duration(days: 1),
                    ),
                  )) {
                if (monthlyData.containsKey(monthYear)) {
                  monthlyData[monthYear]!.add(imc);
                } else {
                  monthlyData[monthYear] = [imc];
                }
              }
            }

            final filteredData = <dynamic>[];

            for (final entry in monthlyData.entries) {
              final monthYear = entry.key;
              final imcList = entry.value;

              final sumImc = imcList.reduce((a, b) => a + b);
              final averageImc = sumImc / imcList.length;

              filteredData.add(
                {
                  'monthYear': monthYear,
                  'imc': averageImc,
                },
              );
            }

            return SfCartesianChart(
              title: ChartTitle(text: 'Historial de IMC'),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                LineSeries<dynamic, String>(
                  name: 'IMC',
                  dataSource: filteredData,
                  xValueMapper: (data, _) => data['monthYear'],
                  yValueMapper: (data, _) => data['imc'],
                  color: Colors.purple[900],
                ),
              ],
            );
          }

          if (filter == CaloriesFoodFilter.year) {
            final yearData = <String, List<double>>{};

            for (final data in imcData) {
              final createdAt = DateFormat('dd-MM-yyyy').parse(
                data['createdAt'],
              );

              final year = createdAt.year.toString();
              final imc = data['imc'].toDouble();

              if (yearData.containsKey(year)) {
                yearData[year]!.add(imc);
              } else {
                yearData[year] = [imc];
              }
            }

            final filteredData = <dynamic>[];

            for (final entry in yearData.entries) {
              final year = entry.key;
              final imcList = entry.value;

              final sumImc = imcList.reduce((a, b) => a + b);
              final averageImc = sumImc / imcList.length;

              filteredData.add(
                {
                  'createdAt': year,
                  'imc': averageImc,
                },
              );
            }

            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                LineSeries<dynamic, String>(
                  name: 'IMC',
                  dataSource: filteredData,
                  xValueMapper: (data, _) => data['createdAt'].toString(),
                  yValueMapper: (data, _) => data['imc'],
                  color: Colors.purple[900],
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  DateFilterWidget _buildDatePicker(filters) {
    return DateFilterWidget(
      filters: filters,
      shouldShowPeriodFilter: true,
      onSubmit: (selectedDateRange, filter) {
        BlocProvider.of<ImcBloc>(context).add(
          GetImcEvent(
            startDate: selectedDateRange.startDate!,
            endDate: selectedDateRange.endDate!,
            filter: filter,
          ),
        );
      },
    );
  }
}
