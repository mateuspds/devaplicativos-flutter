import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool osbscure;
  final TextInputType teclado;
  final TextEditingController nometextedintcontroler;
  const CustomTextField({
    Key? key,
    required this.nometextedintcontroler,
    required this.teclado,
    this.osbscure = false,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        controller: nometextedintcontroler,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.black,
            ),
            labelText: label,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.deepOrange,
                ),
                borderRadius: BorderRadius.circular(10))),
        obscureText: osbscure,
        textInputAction: TextInputAction.next,
        keyboardType: teclado,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "campo obrigatório";
          }
          return null;
        },
      ),
    );
  }
}
