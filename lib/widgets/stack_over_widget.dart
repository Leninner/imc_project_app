import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc_project_app/services/food/bloc/food_bloc.dart';
import 'package:imc_project_app/services/imc/bloc/imc_bloc.dart';
import 'package:imc_project_app/widgets/dashboard/user_food_tab_widget.dart';
import 'package:imc_project_app/widgets/dashboard/user_imc_tab_widget.dart';

class StackOverWidget extends StatefulWidget {
  const StackOverWidget({Key? key}) : super(key: key);

  @override
  _StackOverWidgetState createState() => _StackOverWidgetState();
}

class _StackOverWidgetState extends State<StackOverWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

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
            children: const [
              UserImcTab(),
              UserFoodTab(),
            ],
          ),
        ),
      ],
    );
  }
}
