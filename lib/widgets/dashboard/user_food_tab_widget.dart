import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/services/food/bloc/food_bloc.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/default_table.dart';

class UserFoodTab extends StatelessWidget {
  const UserFoodTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
