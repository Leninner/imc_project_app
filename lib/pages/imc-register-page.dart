import 'package:flutter/material.dart';
import 'package:imc_project_app/widgets/custom_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_routes.dart';
import '../main.dart';
import '../widgets/custom_button.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({Key? key}) : super(key: key);

  @override
  _ImcPageState createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  double imc = 0.0;
  String resultadoTexto = '';

  calcularImc(weight, height){
    setState(() {
      imc = double.parse(weight) /
          (((double.parse(height)) / 100) * ((double.parse(height)) / 100));
      resultadoTexto = double.parse(imc.toStringAsFixed(2)).toString();
    });
  }

  Future<void> _PostImcData(String weight, String height) async {
    calcularImc(weight, height);
    await supabase
        .from('user_imc')
        .insert({
      'userId':supabase.auth.currentUser!.id,
      'height': height,
      'weight':weight,
      'imc':imc,
    });
  }

  limpiarDatos(){
    _weightController.clear();
    _heightController.clear();
    setState(() {
      resultadoTexto = '';
    });
  }

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
        backgroundColor: Colors.purple[800],
        child: const Icon(Icons.arrow_back),
      ),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Calculadora de IMC',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              fontSize: 22.0,
            ),
          ),
        ),
      ),
      body: Column(
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
                    fontSize:  16,
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
                    fontSize:  16,
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
                child:Center(
                  child: Text(
                    'Su indice de masa corporal es: $resultadoTexto',
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
          const SizedBox(height: 20),
          CustomButton(
            onTap: () async {
              if(_weightController.text =='' || _heightController.text ==''){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Ingrese datos en los campos correspondientes'),
                    duration: const Duration(seconds: 5),
                    backgroundColor: Colors.red,
                  ),
                );
              }else if(toInt(_weightController.text)! > 20 && toInt(_weightController.text)! < 300  &&
                       toInt(_heightController.text)! > 20 && toInt(_heightController.text)! < 300 ){
                calcularImc(_weightController.text, _heightController.text);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Ingrese datos entre 20 y 300'),
                    duration: const Duration(seconds: 5),
                    backgroundColor: Colors.red,
                  ),
                );

              }
            },
            buttonText: 'CALCULAR',
            borderRadiusButton: 10,
            buttonColor: Colors.purple[300],
            textColor: Colors.white,
            verticalSizeButton: 15,
            horizontalMarginButton: 80,
            fontSizeButton: 20,
          ),
          const SizedBox(height: 20),
          CustomButton(
            onTap: () async {
              if(_weightController ==null || _heightController == null){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Ingrese datos en los campos correspondientes'),
                    duration: const Duration(seconds: 5),
                    backgroundColor: Colors.red,
                  ),
                );
              }else if(toInt(_weightController.text)! > 20 && toInt(_weightController.text)! < 300  ||
                  toInt(_heightController.text)! > 20 && toInt(_heightController.text)! < 300 ){
                await _PostImcData(
                    _weightController.text, _heightController.text);
                limpiarDatos();
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        'Error en el ingreso de datos, revise y vuelva a intentar'),
                    duration: const Duration(seconds: 5),
                    backgroundColor: Colors.red,
                  ),
                );

              }
            },
            buttonText: 'GUARDAR DATOS',
            borderRadiusButton: 10,
            buttonColor: Colors.purple[800],
            textColor: Colors.white,
            verticalSizeButton: 15,
            horizontalMarginButton: 80,
            fontSizeButton: 20,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text('Aqui va el grafico'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImcPage(),
  ));
}
