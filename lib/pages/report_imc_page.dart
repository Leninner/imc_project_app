import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_routes.dart';
import '../main.dart';
import '../widgets/custom_appbar.dart';

class ImcReportPage extends StatefulWidget {
  const ImcReportPage({super.key});

  @override
  State<ImcReportPage> createState() => _ImcReportPageState();
}

class _ImcReportPageState extends State<ImcReportPage> {
  @override
  void initState() {
    super.initState();
    GetData();
  }

  String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  Future<List<dynamic>> GetData() async {
    final response = await supabase
        .from('user_imc')
        .select('createdAt,imc')
        .eq('userId', supabase.auth.currentUser!.id);
    final formattedDateResponse = response.map((item){
      final createdAt = formatDate(item['createdAt']);
      return{
        'createdAt':createdAt,
        'imc':item['imc'],
      };
    }).toList();

    return formattedDateResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
        backgroundColor: Colors.purple[800],
        child: const Icon(Icons.arrow_back),
      ),
      appBar: const CustomAppBar(titleText: 'Reporte IMC'),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
          });
        },
        child: Center(
          child: Container(
            child: FutureBuilder<List>(
              future: GetData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('IMC:${snapshot.data![index]['imc']}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('Ingresado el: ${snapshot.data![index]['createdAt']}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        ),
      )
    );
  }
}
