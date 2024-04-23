import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDobWidget extends StatefulWidget {
  const EditDobWidget({required this.callback, super.key});

  final Function(String dob) callback;


  @override
  State<EditDobWidget> createState() => _EditDobWidgetState();
}

class _EditDobWidgetState extends State<EditDobWidget> {
  DateTime _date = DateTime.now();

  final TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('d/M/yyyy');


  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _date = widget.callback != null ? _dateFormatter.parse(widget.callback()) : DateTime.now();
  //   _dateController.text = _dateFormatter.format(_date);
  // }
  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
      widget.callback(_dateController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: _dateController,
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
