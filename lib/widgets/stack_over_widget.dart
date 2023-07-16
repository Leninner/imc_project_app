import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/services/imc/bloc/imc_bloc.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/default_table.dart';

class StackOverWidget extends StatefulWidget {
  const StackOverWidget({Key? key}) : super(key: key);

  @override
  _StackOverWidgetState createState() => _StackOverWidgetState();
}

class _StackOverWidgetState extends State<StackOverWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Map<String, String>> userImcList = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    BlocProvider.of<ImcBloc>(context).add(LoadDataEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ImcBloc, ImcState>(
          listener: (context, state) {
            if (state is ImcLoaded) {
              setState(() {
                userImcList.clear();
                userImcList.addAll(state.imc!);
              });
            }

            if (state is ImcError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Ups! Algo salió mal.'),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state is ImcLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('Cargando...'),
                  backgroundColor: Colors.blue,
                ),
              );
            }
          },
        ),
      ],
      child: Column(
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ButtonWidget(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.imc);
                          },
                          label: 'Registrar Índice de Masa Corporal',
                        ),
                        // show a placeholder widget to occupy the space
                        const Placeholder(
                          fallbackHeight: 200,
                          fallbackWidth: double.infinity,
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
                          data: userImcList,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ButtonWidget(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.registerFood);
                          },
                          label: 'Registrar Alimento',
                        ),
                        const Text(
                          'Alimentación',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTable(
                          title: 'Últimos IMC registrados',
                          headers: const [
                            {
                              'label': 'IMC',
                              'tooltip': 'Índice de Masa Corporal',
                              'value': 'imc',
                            },
                            {
                              'label': 'IMC',
                              'tooltip': 'Índice de Masa Corporal',
                              'value': 'imc',
                            },
                            {
                              'label': 'IMC',
                              'tooltip': 'Índice de Masa Corporal',
                              'value': 'imc',
                            },
                          ],
                          data: const [
                            {
                              'name': 'Manzana',
                              'calories': '100',
                              'createdAt': '12/12/2021',
                            },
                            {
                              'name': 'Manzana',
                              'calories': '100',
                              'createdAt': '12/12/2021',
                            },
                            {
                              'name': 'Manzana',
                              'calories': '100',
                              'createdAt': '12/12/2021',
                            },
                            {
                              'name': 'Manzana',
                              'calories': '100',
                              'createdAt': '12/12/2021',
                            },
                            {
                              'name': 'Manzana',
                              'calories': '100',
                              'createdAt': '12/12/2021',
                            },
                            {
                              'name': 'Manzana',
                              'calories': '100',
                              'createdAt': '12/12/2021',
                            },
                            {
                              'name': 'Manzana',
                              'calories': '100',
                              'createdAt': '12/12/2021',
                            }
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
