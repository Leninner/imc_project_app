import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:imc_project_app/widgets/custom_appbar.dart';
import 'package:imc_project_app/widgets/input_field.dart';

class RegisterFoodPage extends StatefulWidget {
  const RegisterFoodPage({super.key});

  @override
  State<RegisterFoodPage> createState() => _RegisterFoodPageState();
}

class _RegisterFoodPageState extends State<RegisterFoodPage> {
  final foodFormKey = GlobalKey<FormState>();
  final TextEditingController _caloriesController = TextEditingController();
  bool _useDefaultCalories = false;

  void handleUseDefaultCalories() {
    setState(() {
      _useDefaultCalories = !_useDefaultCalories;
    });
  }

  void handleSubmit() {}

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
                DropdownSearch<String>(
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
                  items: const [
                    'Carne',
                    'Pollo',
                    'Pescado',
                    'Huevo',
                  ],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Alimento',
                      hintText: 'Seleccione un alimento',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                InputField(
                  label: 'Calorías',
                  controller: _caloriesController,
                  hintText: 'Ej 100',
                  disabled: _useDefaultCalories,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: _useDefaultCalories,
                      onChanged: (isSelected) {
                        handleUseDefaultCalories();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        handleUseDefaultCalories();
                      },
                      child: const Text(
                        'Usar calorías por defecto',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tipo de comida *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Desayuno',
                      child: Text('Desayuno'),
                    ),
                    DropdownMenuItem(
                      value: 'Almuerzo',
                      child: Text('Almuerzo'),
                    ),
                    DropdownMenuItem(
                      value: 'Cena',
                      child: Text('Cena'),
                    ),
                  ],
                  onChanged: (data) {},
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
