import 'package:first_project/widgets/cm_widgets/cm_repo.dart';
import 'package:flutter/material.dart';

class CmNumberField extends StatelessWidget {
  const CmNumberField(
      {super.key,
      required this.title,
      required this.controller,
      required this.label,
      this.readOnly});
  final String title;
  final TextEditingController controller;
  final String label;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CmRepo().titleText(title),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            fillColor: Colors.white60,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white12),
            ),
          ),
          readOnly: readOnly ?? false,
          validator: (val) {
            if (val!.isEmpty) {
              return 'Plz insert any number!';
            } else {
              final intValue = int.tryParse(val);
              if (intValue == null) return "Plz provide valid value";
              return null;
            }
          },
        ),
      ],
    );
  }
}
