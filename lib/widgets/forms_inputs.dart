import 'package:fisioflex_mobile/config/theme.dart';
import 'package:flutter/material.dart';

Widget textInputWidget(
    String label,
    TextEditingController controller,
    TextInputType type,
    bool obscure,
    Icon icon,
    String? Function(String?)? validator) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    child: TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      validator: validator, // Agrega la función de validación aquí.
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
        prefixIcon: icon,
      ),
    ),
  );
}

Widget buttonSubmitWidget(
    String label, Function() onPressed, BuildContext context) {
  return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.09,
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
        child: Text(label),
      ));
}

Widget textInputtWithoutlabel(String label, TextEditingController controller,
    TextInputType type, bool obscure, Icon icon, Function(String) onChange) {
  return Container(
      padding: EdgeInsets.all(12.0),
      child: TextFormField(
          onChanged: onChange,
          controller: controller,
          keyboardType: type,
          obscureText: obscure,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red, width: 2.0)),
            alignLabelWithHint: false,
            labelText: label,
            prefixIcon: icon,
          )));
}
