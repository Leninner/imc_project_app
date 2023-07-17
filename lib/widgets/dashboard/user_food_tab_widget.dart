import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/services/food/bloc/food_bloc.dart';
import 'package:imc_project_app/services/food/index.dart';
import 'package:imc_project_app/utils/date_utils.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/default_table.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
                  _buildUserFoodChart(state, context),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildUserFoodTable(state),
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

  DefaultTable _buildUserFoodTable(FoodLoaded state) {
    return DefaultTable(
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
      data: state.foodList,
    );
  }

  Container _buildUserFoodChart(FoodLoaded state, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SfCartesianChart(
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: CategoryAxis(
              // change these when the user can filter by week or month
              labelRotation: CaloriesFoodFilter.week == CaloriesFoodFilter.week
                  ? -45
                  : CaloriesFoodFilter.month == CaloriesFoodFilter.month
                      ? 0
                      : 90,
            ),
            title: ChartTitle(text: 'Historial de alimentos'),
            legend: const Legend(
              isVisible: true,
              position: LegendPosition.bottom,
            ),
            series: <LineSeries<UserFoodDataModel, String>>[
              LineSeries<UserFoodDataModel, String>(
                dataSource: <UserFoodDataModel>[
                  for (final food in state.caloriesByFilter)
                    UserFoodDataModel.fromJson(food)
                ],
                xValueMapper: (UserFoodDataModel sales, _) => sales.month,
                yValueMapper: (UserFoodDataModel sales, _) => sales.calories,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class UserFoodDataModel {
  final String month;
  final double calories;

  static final List<String> months = [
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Oct',
    'Nov',
    'Dic',
  ];

  static final List<String> days = [
    'Lun',
    'Mar',
    'Mie',
    'Jue',
    'Vie',
    'Sab',
    'Dom',
  ];

  UserFoodDataModel(this.month, this.calories);

  factory UserFoodDataModel.fromJson(Map<String, String> data) {
    if (data['month'] != null) {
      return UserFoodDataModel(
        months[int.parse(data['month']!) - 1],
        double.parse(data['calories']!),
      );
    }

    if (data['day'] != null) {
      return UserFoodDataModel(
        data['day']!,
        double.parse(data['calories']!),
      );
    }

    if (data['week_start'] != null) {
      return UserFoodDataModel(
        'Semana ${formatDate(data['week_start']!)}',
        double.parse(data['calories']!),
      );
    }

    if (data['year'] != null) {
      return UserFoodDataModel(
        data['year']!,
        double.parse(data['calories']!),
      );
    }

    return UserFoodDataModel(
      months[int.parse(data['month']!) - 1],
      double.parse(data['calories']!),
    );
  }
}