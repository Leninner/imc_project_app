import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/widgets/button_widget.dart';

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
              Tab(
                text: 'Índice de Masa Corporal',
              ),
              Tab(
                text: 'Alimentación',
              ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.imc);
                      },
                      label: 'Registrar IMC',
                    ),
                    const Text(
                      'IMC',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'IMC',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.registerFood);
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
                    const Text(
                      'Alimentación',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
