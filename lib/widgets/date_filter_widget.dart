import 'package:flutter/material.dart';
import 'package:imc_project_app/services/food/index.dart';
import 'package:imc_project_app/utils/date_utils.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateFilterWidget extends StatefulWidget {
  final Function(PickerDateRange data, CaloriesFoodFilter filter)? onSubmit;
  final Function()? onCancel;
  final Map<String, dynamic>? filters;

  const DateFilterWidget({
    super.key,
    this.onSubmit,
    this.onCancel,
    this.filters,
  });

  @override
  State<DateFilterWidget> createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  final _datePickerController = DateRangePickerController();
  bool _showDateFilter = false;
  CaloriesFoodFilter _selectedFilter = CaloriesFoodFilter.day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showDateFilter) _buildDateFilter() else _buildDateFilterButtons(),
      ],
    );
  }

  Widget _buildDateFilterButtons() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Desde ${formatDate(
                widget.filters!['startDate'].toString(),
              )} hasta ${formatDate(
                widget.filters!['endDate'].toString(),
              )}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            ButtonWidget(
              onPressed: () {
                setState(() {
                  _showDateFilter = true;
                });
              },
              width: 200,
              label: 'Filtro',
              icon: Icons.filter_alt_outlined,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: 'Filtro',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          value: widget.filters!['filter'],
          items: CaloriesFoodFilter.values
              .map(
                (e) => DropdownMenuItem(
                  value: CaloriesFoodFilter.values[e.index],
                  child: Text(
                    _resolveFilter(CaloriesFoodFilter.values[e.index]),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedFilter = value as CaloriesFoodFilter;
            });
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null) {
              return 'Selecciona una opción';
            }

            return null;
          },
        )
      ],
    );
  }

  SfDateRangePicker _buildDateFilter() {
    return SfDateRangePicker(
      maxDate: DateTime.now(),
      initialSelectedRange: _datePickerController.selectedRange,
      selectionMode: DateRangePickerSelectionMode.range,
      monthFormat: 'MMM',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      showActionButtons: true,
      onSubmit: (selectedDateRange) {
        if (selectedDateRange == null) {
          setState(() {
            _datePickerController.selectedRange = PickerDateRange(
              DateTime.now().subtract(
                const Duration(days: 15),
              ),
              DateTime.now(),
            );
          });

          return;
        }

        if ((selectedDateRange as PickerDateRange).startDate == null ||
            selectedDateRange.endDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Selecione un período válido',
                style: TextStyle(),
              ),
              backgroundColor: Colors.red,
            ),
          );

          setState(() {
            _datePickerController.selectedRange = PickerDateRange(
              DateTime.now().subtract(
                const Duration(days: 15),
              ),
              DateTime.now(),
            );
          });

          setState(() {
            _showDateFilter = false;
          });

          return;
        }

        if (widget.onSubmit == null) return;

        widget.onSubmit!(
          selectedDateRange,
          _selectedFilter,
        );

        setState(() {
          _datePickerController.selectedRange = selectedDateRange;
        });
      },
      onCancel: () {
        setState(
          () {
            _datePickerController.selectedRange = PickerDateRange(
              DateTime.now().subtract(
                const Duration(days: 15),
              ),
              DateTime.now(),
            );

            _showDateFilter = false;
          },
        );

        if (widget.onCancel == null) return;

        widget.onCancel!();
      },
    );
  }

  @override
  void dispose() {
    _datePickerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _datePickerController.selectedRange = PickerDateRange(
      DateTime.now().subtract(
        const Duration(days: 15),
      ),
      DateTime.now(),
    );
    super.initState();
  }

  String _resolveFilter(CaloriesFoodFilter filter) {
    switch (filter) {
      case CaloriesFoodFilter.day:
        return 'Diario';
      case CaloriesFoodFilter.month:
        return 'Mensual';
      case CaloriesFoodFilter.week:
        return 'Semanal';
      default:
        return 'Anual';
    }
  }

  List<Object?> get props =>
      [_datePickerController.selectedRange, _selectedFilter];
}
