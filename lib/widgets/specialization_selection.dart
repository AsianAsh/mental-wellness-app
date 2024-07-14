import 'package:flutter/material.dart';

class MultiSelect extends FormField<List<String>> {
  MultiSelect({
    required List<String> items,
    required List<String> initialSelectedItems,
    required FormFieldSetter<List<String>> onSaved,
    required FormFieldValidator<List<String>> validator,
    required BuildContext context,
    Key? key,
  }) : super(
          key: key,
          initialValue: initialSelectedItems,
          onSaved: onSaved,
          validator: validator,
          builder: (FormFieldState<List<String>> state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: SizedBox(
                height: 50,
                child: GestureDetector(
                  onTap: () async {
                    List<String>? selectedItems =
                        await showDialog<List<String>>(
                      context: context,
                      builder: (BuildContext context) {
                        return MultiSelectDialog(
                          items: items,
                          initialSelectedItems: state.value ?? [],
                        );
                      },
                    );
                    if (selectedItems != null) {
                      state.didChange(selectedItems);
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Select Specializations',
                      hintStyle: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                      errorText: state.hasError ? state.errorText : null,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.value != null && state.value!.isNotEmpty
                            ? state.value!.join(', ')
                            : 'Specializations',
                        style: state.value != null && state.value!.isNotEmpty
                            ? TextStyle(color: Colors.black, fontSize: 16.0)
                            : TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> initialSelectedItems;

  MultiSelectDialog({required this.items, required this.initialSelectedItems});

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.initialSelectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Specializations'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: _selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (isChecked) {
                setState(() {
                  if (isChecked ?? false) {
                    if (_selectedItems.length < 3) {
                      _selectedItems.add(item);
                    }
                  } else {
                    _selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context, _selectedItems);
          },
        ),
      ],
    );
  }
}
