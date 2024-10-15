import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StyledDropdown extends StatelessWidget {
  final String hint;
  final List<String> options;
  final Rx<String?> selectedValue;
  final Function() validate;

  const StyledDropdown({
    Key? key,
    required this.hint,
    required this.options,
    required this.selectedValue,
    required this.validate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
          ),
          hint: Text(hint),
          value: selectedValue.value,
          onChanged: (newValue) {
            selectedValue.value = newValue;
            validate();
          },
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
        ));
  }
}