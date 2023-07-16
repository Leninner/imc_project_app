import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/services/food/bloc/food_bloc.dart';
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
          Future.delayed(Duration.zero, () async {
            setState(() {
              userFoodList.clear();
              userFoodList.addAll(state.foodList);
            });
          });
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
                    Navigator.of(context).pushNamed(
                      Routes.registerFood,
                    );
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
                      'tooltip': 'El horario en el que se registró el alimento',
                      'value': 'scheduleName',
                    },
                  ],
                  data: userFoodList,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BlocBuilder<ImcBloc, ImcState> _buildImcTab() {
    return BlocBuilder<ImcBloc, ImcState>(
      builder: (context, state) {
        if (state is ImcLoaded) {
          Future.delayed(Duration.zero, () async {
            setState(() {
              userImcList.clear();
              userImcList.addAll(state.imc);
            });
          });
        }

        if (state is ImcError) {
          return const SnackBar(
            content: Text('Un error ha ocurrido'),
          );
        }

        if (state is ImcLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

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
        );
      },
    );
  }
}
