import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/services/food/bloc/food_bloc.dart';
import 'package:imc_project_app/services/imc/bloc/imc_bloc.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/default_table.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../main.dart';

class StackOverWidget extends StatefulWidget {
  const StackOverWidget({Key? key}) : super(key: key);

  @override
  _StackOverWidgetState createState() => _StackOverWidgetState();
}

String formatDate(String dateString) {
  final dateTime = DateTime.parse(dateString);
  final formatter = DateFormat('dd-MM-yyyy');

  return formatter.format(dateTime);
}

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

class _StackOverWidgetState extends State<StackOverWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Map<String, String>> userImcList = [];
  final List<Map<String, String>> userFoodList = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    if (mounted) {
      BlocProvider.of<ImcBloc>(context).add(GetImcEvent());
      BlocProvider.of<FoodBloc>(context).add(GetFoodEvent());
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TabBar(
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              color: const Color.fromRGBO(44, 43, 71, 1),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blueGrey[500],
            tabs: const [
              Tab(text: 'Índice de Masa Corporal'),
              Tab(text: 'Alimentación'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              _buildImcTab(),
              _buildFoodTab(),
            ],
          ),
        ),
      ],
    );
  }

  BlocBuilder<FoodBloc, FoodState> _buildFoodTab() {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state is FoodLoaded) {
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
                      Navigator.of(context).pushReplacementNamed(
                        Routes.registerFood,
                      );
                    },
                    label: 'Registrar Alimento',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultTable(
                    title: 'Últimos alimentos registrados',
                    headers: const [
                      {
                        'label': 'Nombre',
                        'tooltip': 'Nombre del alimento',
                        'value': 'name',
                      },
                      {
                        'label': 'Calorías (Cal)',
                        'tooltip': 'Calorías del alimento',
                        'value': 'calories',
                      },
                      {
                        'label': 'Fecha de registro',
                        'tooltip': 'Fecha en la que se registró el alimento',
                        'value': 'createdAt',
                      },
                      {
                        'label': 'Horario de comida',
                        'tooltip':
                            'El horario en el que se registró el alimento',
                        'value': 'scheduleName',
                      },
                    ],
                    data: state.foodList,
                  ),
                ],
              ),
            ),
          );
        }

        if (state is FoodError) {
          if (context.findAncestorWidgetOfExactType<SnackBar>() != null) {
            setState(() {
              userFoodList.clear();
            });

            return const SizedBox.shrink();
          }

          return const SnackBar(
            content: Text('Un error ha ocurrido al cargar los alimentos'),
          );
        }

        if (state is FoodLoading) {
          if (context
                  .findAncestorWidgetOfExactType<CircularProgressIndicator>() !=
              null) {
            return const SizedBox.shrink();
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  BlocBuilder<ImcBloc, ImcState> _buildImcTab() {
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
}
