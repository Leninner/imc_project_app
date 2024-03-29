import 'package:flutter/material.dart';
import 'package:imc_project_app/constants/app_routes.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:imc_project_app/widgets/custom_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../widgets/custom_appbar.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  _ImcPageState createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  double imc = 0.0;
  String resultText = '';

  calculateImc(weight, height) {
    setState(() {
      imc = double.parse(weight) /
          (((double.parse(height)) / 100) * ((double.parse(height)) / 100));
      resultText = double.parse(imc.toStringAsFixed(2)).toString();
    });
  }

  Future<void> _postImcData(String weight, String height) async {
    calculateImc(weight, height);
    await supabase.from('user_imc').insert({
      'userId': supabase.auth.currentUser!.id,
      'height': height,
      'weight': weight,
      'imc': imc,
    });
  }

  cleanData() {
    _weightController.clear();
    _heightController.clear();
    setState(() {
      resultText = '';
    });
  }

  successMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Datos ingresados correctamente'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacementNamed(context, Routes.home);
  }

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Registro de IMC',
        toBackRouteName: Routes.home,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _heightController,
                        keyboardType: TextInputType.number,
                        hintText: 'ALTURA',
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'CM Ejemplo:(175 cm)',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        hintText: 'PESO',
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'KG Ejemplo:(70,5 kg)',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Su indice de masa corporal es: $resultText',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  onPressed: () async {
                    if (_weightController.text == '' ||
                        _heightController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Ingrese datos en los campos correspondientes',
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (toInt(_weightController.text)! > 20 &&
                        toInt(_weightController.text)! < 300 &&
                        toInt(_heightController.text)! > 20 &&
                        toInt(_heightController.text)! < 300) {
                      calculateImc(
                          _weightController.text, _heightController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ingrese datos entre 20 y 300'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  label: 'Calcular',
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  onPressed: () async {
                    if (_weightController.text == '' ||
                        _heightController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Ingrese datos en los campos correspondientes',
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (toInt(_weightController.text)! > 20 &&
                            toInt(_weightController.text)! < 300 ||
                        toInt(_heightController.text)! > 20 &&
                            toInt(_heightController.text)! < 300) {
                      await _postImcData(
                        _weightController.text,
                        _heightController.text,
                      );
                      cleanData();
                      successMessage();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Error en el ingreso de datos, revise y vuelva a intentar',
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  label: 'Guardar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
