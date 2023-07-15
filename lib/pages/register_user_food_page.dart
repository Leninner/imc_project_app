import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:imc_project_app/services/food/models/food_model.dart';
import 'package:imc_project_app/services/food/index.dart';
import 'package:imc_project_app/services/food/models/schedule_model.dart';
import 'package:imc_project_app/widgets/custom_appbar.dart';
import 'package:imc_project_app/widgets/input_field.dart';

class RegisterUserFoodPage extends StatefulWidget {
  const RegisterUserFoodPage({super.key});

  @override
  State<RegisterUserFoodPage> createState() => _RegisterUserFoodPageState();
}

class _RegisterUserFoodPageState extends State<RegisterUserFoodPage> {
  final _selectFoodKey = GlobalKey<DropdownSearchState<FoodModel>>();
  final _selectScheduleKey = GlobalKey<DropdownSearchState<ScheduleModel>>();

  final TextEditingController _foodScheduleController = TextEditingController();

  final foodFormKey = GlobalKey<FormState>();
  final TextEditingController _caloriesController = TextEditingController();
  bool isLoading = false;

  void handleSubmit() async {
    if (foodFormKey.currentState!.validate()) {
      final foodId = _selectFoodKey.currentState?.getSelectedItem?.id ?? '';
      final scheduleId =
          _selectScheduleKey.currentState?.getSelectedItem?.id ?? '';
      final calories = _caloriesController.text;

      final prevResult = await FoodService().saveUserFood(
        foodId: foodId,
        scheduleId: scheduleId,
        calories: calories,
      );

      prevResult.fold(
        (l) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No se pudo guardar el alimento',
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        },
        (r) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Alimento guardado con éxito',
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.of(context).pop();
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor, corrige los errores',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Alimentación'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: foodFormKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DropdownSearch<FoodModel>(
                  key: _selectFoodKey,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value == null ? 'Seleccione un alimento' : null,
                  popupProps: const PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar',
                      ),
                    ),
                  ),
                  asyncItems: (text) async {
                    final result = await FoodService().getFoods();

                    return result.fold(
                      (l) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No se pudieron obtener los alimentos',
                            ),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                          ),
                        );

                        return [];
                      },
                      (r) => r,
                    );
                  },
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Alimento *',
                      hintText: 'Seleccione un alimento',
                    ),
                  ),
                  itemAsString: (item) => '${item.name} (${item.calories} cal)',
                  onChanged: (FoodModel? food) {
                    if (food != null) {
                      setState(() {
                        _caloriesController.text = food.calories.toString();
                      });
                    }
                  },
                ),
                const SizedBox(height: 18),
                InputField(
                  label: 'Cantidad de calorías *',
                  controller: _caloriesController,
                  hintText: 'Ej 100',
                  shouldHas: InputTypes.onlyNumbers,
                ),
                const SizedBox(height: 18),
                DropdownSearch<ScheduleModel>(
                  key: _selectScheduleKey,
                  onChanged: (data) {
                    _foodScheduleController.text = data.toString();
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value == null ? 'Seleccione un tipo de comida' : null,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Horario de comida *',
                    ),
                  ),
                  asyncItems: (text) async {
                    final result = await FoodService().getSchedules();

                    return result.fold(
                      (l) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'No se pudieron obtener los horarios de comida',
                            ),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.red,
                          ),
                        );

                        return [];
                      },
                      (r) => r,
                    );
                  },
                  itemAsString: (item) => item.name,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Color.fromRGBO(44, 43, 71, 1),
                              ),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Color.fromRGBO(44, 43, 71, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(44, 43, 71, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: handleSubmit,
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
