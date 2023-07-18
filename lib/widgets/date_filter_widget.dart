import 'package:flutter/material.dart';
import 'package:imc_project_app/utils/date_utils.dart';
import 'package:imc_project_app/widgets/button_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateFilterWidget extends StatefulWidget {
  final Function(PickerDateRange data)? onSubmit;
  final Function()? onCancel;

  const DateFilterWidget({
    super.key,
    this.onSubmit,
    this.onCancel,
  });

  @override
  State<DateFilterWidget> createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  final _datePickerController = DateRangePickerController();
  bool _showDateFilter = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_showDateFilter) _buildDateFilter() else _buildDateFilterButton(),
      ],
    );
  }

  Widget _buildDateFilterButton() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Desde ${formatDate(_datePickerController.selectedRange!.startDate.toString())} hasta ${formatDate(_datePickerController.selectedRange!.endDate.toString())}',
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
            )
          ],
        ),
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

  PickerDateRange? get selectedRange => _datePickerController.selectedRange;
}
