import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDobWidget extends StatefulWidget {
  const EditDobWidget({required this.dateController, super.key});

  final TextEditingController dateController;

  @override
  State<EditDobWidget> createState() => _EditDobWidgetState();
}

class _EditDobWidgetState extends State<EditDobWidget> {
  DateTime _date = DateTime.now();

  final DateFormat _dateFormatter = DateFormat('DD-MM-YYYY');

  @override
  void dispose() {
    widget.dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      widget.dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.dateController,
      style: const TextStyle(
        fontSize: 18,
      ),
      onTap: _handleDatePicker,
      decoration: InputDecoration(
        labelText: 'Date',
        labelStyle: const TextStyle(
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
