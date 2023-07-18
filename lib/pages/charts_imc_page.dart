import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../main.dart';

class ImcChartReportPage extends StatefulWidget {
  const ImcChartReportPage({Key? key}) : super(key: key);

  @override
  State<ImcChartReportPage> createState() => _ImcChartReportPageState();
}

class _ImcChartReportPageState extends State<ImcChartReportPage> {
  String _selectedFilter = 'Semanal';

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
    final formattedDateResponse = response.map((item) {
      final createdAt = formatDate(item['createdAt']);
      return {
        'createdAt': createdAt,
        'imc': item['imc'],
      };
    }).toList();

    return formattedDateResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC Reports'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 400,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FutureBuilder<List<dynamic>>(
                    future: GetData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        final imcData = snapshot.data!;

                        imcData.sort(
                          (a, b) => DateFormat('dd-MM-yyyy')
                              .parse(a['createdAt'])
                              .compareTo(
                                DateFormat('dd-MM-yyyy').parse(
                                  b['createdAt'],
                                ),
                              ),
                        );

                        if (_selectedFilter == 'Diario') {
                          final imcData = snapshot.data!;
                          imcData.sort(
                            (a, b) => DateFormat('dd-MM-yyyy')
                                .parse(a['createdAt'])
                                .compareTo(
                                  DateFormat('dd-MM-yyyy')
                                      .parse(b['createdAt']),
                                ),
                          );

                          final currentDate = DateTime.now();

                          final firstDayOfMonth = DateTime(
                            currentDate.year,
                            currentDate.month,
                            1,
                          );

                          final lastDayOfMonth = DateTime(
                            currentDate.year,
                            currentDate.month + 1,
                            0,
                          );

                          final filteredData = imcData.where((item) {
                            final createdAt = DateFormat('dd-MM-yyyy').parse(
                              item['createdAt'],
                            );

                            return createdAt.isAfter(
                                  firstDayOfMonth.subtract(
                                    const Duration(days: 1),
                                  ),
                                ) &&
                                createdAt.isBefore(
                                  lastDayOfMonth.add(
                                    const Duration(days: 1),
                                  ),
                                );
                          }).toList();

                          return SfCartesianChart(
                            primaryXAxis: DateTimeAxis(
                              dateFormat: DateFormat('dd-MM-yyyy'),
                              labelRotation: 90,
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries>[
                              LineSeries<dynamic, DateTime>(
                                name: 'IMC',
                                dataSource: filteredData,
                                xValueMapper: (data, _) => DateFormat(
                                  'dd-MM-yyyy',
                                ).parse(
                                  data['createdAt'],
                                ),
                                yValueMapper: (data, _) => data['imc'],
                                color: Colors.purple[900],
                              ),
                            ],
                          );
                        }

                        if (_selectedFilter == 'Semanal') {
                          final currentDate = DateTime.now();

                          final weekStart = currentDate.subtract(
                            Duration(days: currentDate.weekday - 1),
                          );
                          final weekEnd = weekStart.add(
                            const Duration(days: 6),
                          );

                          final filteredData = imcData.where((item) {
                            final createdAt = DateFormat('dd-MM-yyyy').parse(
                              item['createdAt'],
                            );

                            return createdAt.isAfter(
                                  weekStart.subtract(
                                    const Duration(days: 1),
                                  ),
                                ) &&
                                createdAt.isBefore(
                                  weekEnd.add(
                                    const Duration(days: 1),
                                  ),
                                );
                          }).toList();

                          return SfCartesianChart(
                            primaryXAxis: DateTimeAxis(
                              dateFormat: DateFormat('dd-MM-yyyy'),
                              labelRotation: 90,
                            ),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries>[
                              LineSeries<dynamic, DateTime>(
                                name: 'IMC',
                                dataSource: filteredData,
                                xValueMapper: (data, _) => DateFormat(
                                  'dd-MM-yyyy',
                                ).parse(
                                  data['createdAt'],
                                ),
                                yValueMapper: (data, _) => data['imc'],
                                color: Colors.purple[900],
                              ),
                            ],
                          );
                        }

                        if (_selectedFilter == 'Mensual') {
                          final currentDate = DateTime.now();

                          final firstDayOfYear = DateTime(
                            currentDate.year,
                            1,
                            1,
                          );

                          final lastDayOfYear = DateTime(
                            currentDate.year,
                            12,
                            31,
                          );

                          final monthlyData = <String, List<double>>{};

                          for (final data in imcData) {
                            final createdAt = DateFormat('dd-MM-yyyy').parse(
                              data['createdAt'],
                            );

                            final monthYear = DateFormat('MMMM-yyyy').format(
                              createdAt,
                            );

                            final imc = data['imc'].toDouble();

                            if (createdAt.isAfter(
                                  firstDayOfYear.subtract(
                                    const Duration(days: 1),
                                  ),
                                ) &&
                                createdAt.isBefore(
                                  lastDayOfYear.add(
                                    const Duration(days: 1),
                                  ),
                                )) {
                              if (monthlyData.containsKey(monthYear)) {
                                monthlyData[monthYear]!.add(imc);
                              } else {
                                monthlyData[monthYear] = [imc];
                              }
                            }
                          }

                          final filteredData = <dynamic>[];

                          for (final entry in monthlyData.entries) {
                            final monthYear = entry.key;
                            final imcList = entry.value;

                            final sumImc = imcList.reduce((a, b) => a + b);
                            final averageImc = sumImc / imcList.length;

                            filteredData.add(
                              {
                                'monthYear': monthYear,
                                'imc': averageImc,
                              },
                            );
                          }

                          return SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries>[
                              LineSeries<dynamic, String>(
                                name: 'IMC',
                                dataSource: filteredData,
                                xValueMapper: (data, _) => data['monthYear'],
                                yValueMapper: (data, _) => data['imc'],
                                color: Colors.purple[900],
                              ),
                            ],
                          );
                        }

                        if (_selectedFilter == 'Anual') {
                          final yearData = <String, List<double>>{};

                          for (final data in imcData) {
                            final createdAt = DateFormat('dd-MM-yyyy').parse(
                              data['createdAt'],
                            );

                            final year = createdAt.year.toString();
                            final imc = data['imc'].toDouble();

                            if (yearData.containsKey(year)) {
                              yearData[year]!.add(imc);
                            } else {
                              yearData[year] = [imc];
                            }
                          }

                          final filteredData = <dynamic>[];

                          for (final entry in yearData.entries) {
                            final year = entry.key;
                            final imcList = entry.value;

                            final sumImc = imcList.reduce((a, b) => a + b);
                            final averageImc = sumImc / imcList.length;

                            filteredData.add(
                              {
                                'createdAt': year,
                                'imc': averageImc,
                              },
                            );
                          }

                          return SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <ChartSeries>[
                              LineSeries<dynamic, String>(
                                name: 'IMC',
                                dataSource: filteredData,
                                xValueMapper: (data, _) =>
                                    data['createdAt'].toString(),
                                yValueMapper: (data, _) => data['imc'],
                                color: Colors.purple[900],
                              ),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
