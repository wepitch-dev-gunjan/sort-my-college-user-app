import 'package:flutter/material.dart';

class DropDownDialog extends StatefulWidget {
  const DropDownDialog({
    required this.itemList,
    required this.label,
    required this.callback,
    super.key,
  });

  final List<String> itemList;
  final String label;
  final Function(String? value) callback;

  @override
  State<DropDownDialog> createState() => _DropDownDialogState();
}

class _DropDownDialogState extends State<DropDownDialog> {
  String? currentValue;

  @override
  void initState() {
    setInitialValue();
    super.initState();
  }

  void setInitialValue() {
    if (widget.itemList.isNotEmpty) {
      currentValue = widget.itemList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.label),
      content: DropdownButton<String>(
        value: currentValue,
        onChanged: (String? item) {
          widget.callback(item);
          Navigator.pop(context, item);
        },
        items: widget.itemList.map(
          (e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          },
        ).toList(),
      ),
    );
  }
}
