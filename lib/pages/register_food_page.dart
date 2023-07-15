import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/custom_appbar.dart';
import 'package:imc_project_app/widgets/input_field.dart';

class RegisterFoodPage extends StatefulWidget {
  const RegisterFoodPage({super.key});

  @override
  State<RegisterFoodPage> createState() => _RegisterFoodPageState();
}

class _RegisterFoodPageState extends State<RegisterFoodPage> {
  bool? _popupBuilderSelection = false;
  final _popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final foodFormKey = GlobalKey<FormState>();
  final TextEditingController _caloriesController = TextEditingController();
  bool _useDefaultCalories = false;

  void handleUseDefaultCalories() {
    setState(() {
      _useDefaultCalories = !_useDefaultCalories;
    });
  }

  @override
  Widget build(BuildContext context) {
    void handleCheckBoxState({bool updateState = true}) {
      var selectedItem =
          _popupBuilderKey.currentState?.popupGetSelectedItems ?? [];
      var isAllSelected =
          _popupBuilderKey.currentState?.popupIsAllItemSelected ?? false;
      _popupBuilderSelection =
          selectedItem.isEmpty ? false : (isAllSelected ? true : null);

      if (updateState) setState(() {});
    }

    handleCheckBoxState(updateState: false);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Alimentación'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
                      child: const Text('Usar calorías por defecto'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
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
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Guardar'),
                    ),
                  ],
                )
                // DropdownSearch<String>.multiSelection(
                //   key: _popupBuilderKey,
                //   items: List.generate(30, (index) => "$index"),
                //   popupProps: PopupPropsMultiSelection.dialog(
                //     onItemAdded: (l, s) => handleCheckBoxState(),
                //     onItemRemoved: (l, s) => handleCheckBoxState(),
                //     showSearchBox: true,
                //     searchFieldProps: const TextFieldProps(
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(),
                //         prefixIcon: Icon(Icons.search),
                //         hintText: 'Buscar',
                //       ),
                //     ),
                //     containerBuilder: (ctx, popupWidget) {
                //       return _CheckBoxWidget(
                //         isSelected: _popupBuilderSelection,
                //         onChanged: (v) {
                //           if (v == true) {
                //             _popupBuilderKey.currentState!
                //                 .popupSelectAllItems();
                //           } else if (v == false) {
                //             _popupBuilderKey.currentState!
                //                 .popupDeselectAllItems();
                //             handleCheckBoxState();
                //           }
                //         },
                //         child: popupWidget,
                //       );
                //     },
                //   ),
                //   dropdownDecoratorProps: const DropDownDecoratorProps(
                //     dropdownSearchDecoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Alimentos',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckBoxWidget extends StatefulWidget {
  final Widget child;
  final bool? isSelected;
  final ValueChanged<bool?>? onChanged;

  _CheckBoxWidget({required this.child, this.isSelected, this.onChanged});

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<_CheckBoxWidget> {
  bool? isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant _CheckBoxWidget oldWidget) {
    if (widget.isSelected != isSelected) isSelected = widget.isSelected;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0x88F44336),
            Colors.blue,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Select: '),
              Checkbox(
                  value: isSelected,
                  tristate: true,
                  onChanged: (bool? v) {
                    if (v == null) v = false;
                    setState(() {
                      isSelected = v;
                      if (widget.onChanged != null) widget.onChanged!(v);
                    });
                  }),
            ],
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}
