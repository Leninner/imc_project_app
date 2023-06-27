import 'package:flutter/material.dart';
import 'package:imc_project_app/widgets/button_widget.dart';

import '../main.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ImcPage extends StatelessWidget {
  const ImcPage({super.key});

  @override
  Widget build(BuildContext context) {



    Future<void> _Getdata() async {
      final data = await supabase
          .from('user_imc')
          .select('*');
      print(data);
    };

    Future<void> _PostImcData(weight,height) async {

      await supabase
          .from('user_imc')
          .insert({
            'userId':supabase.auth.currentUser!.id,
            'height': height,
            'weight':weight,
          });
    };
    TextEditingController _weightController = TextEditingController();
    TextEditingController _heightController = TextEditingController();



    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
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
                child: Text('CM Ejemplo:(175 cm)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
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
                child: Text('KG Ejemplo:(70,5 kg)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: const SizedBox(width: 1,)),
              Expanded(
                child: CustomTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'IMC RESULTANTE',
                ),
              ),
              Expanded(child: const SizedBox(width: 1,)),
            ],
          ),
          const SizedBox(height: 10,),
          CustomButton(
            onTap: (){
              _PostImcData(_weightController.text,_heightController.text);
            },
            buttonText: 'CALCULAR',
            verticalSizeButton: 10,
            horizontalMarginButton: 125,
            buttonColor: Colors.deepPurple,
            textColor: Colors.white,
            borderRadiusButton: 10,
          ),
          const SizedBox(height: 20,),
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
