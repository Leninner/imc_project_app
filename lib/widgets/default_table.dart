import 'package:flutter/material.dart';

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data;
  final List<String> columns;

  MyData({
    required List<Map<String, String>> data,
    required this.columns,
  }) : _data = data;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      for (var i = 0; i < columns.length; i++)
        DataCell(
          Text(
            _data[index][columns[i]] ?? '',
            style: const TextStyle(
              decoration: TextDecoration.none,
            ),
          ),
        ),
    ]);
  }
}

class DefaultTable extends StatelessWidget {
  final List<Map<String, dynamic>> headers;
  final List<Map<String, String>> data;
  final DataTableSource _data;
  final String title;

  DefaultTable({
    super.key,
    required this.headers,
    required this.data,
    required this.title,
  }) : _data = MyData(
          data: data,
          columns: headers.map<String>((e) => e['value']).toList(),
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PaginatedDataTable(
        source: _data,
        header: Text(title),
        columns: headers
            .map<DataColumn>(
              (e) => DataColumn(
                label: Text(
                  e['label'],
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                  ),
                ),
                tooltip: e['tooltip'],
              ),
            )
            .toList(),
        rowsPerPage: 8,
        showCheckboxColumn: false,
        columnSpacing: 100,
      ),
    );
  }
}
