import 'package:flutter/material.dart';

class CustomTogle extends StatelessWidget {
  final List<bool> selectBool;
  final List<String> selectTexto;
  final Function(int newindex) FuctionEle;
  const CustomTogle({
    Key? key,
    required this.FuctionEle,
    required this.selectTexto,
    required this.selectBool,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Colors.red[700],
      selectedColor: Colors.white,
      fillColor: Colors.red[200],
      constraints: const BoxConstraints(
        minHeight: 40,
        minWidth: 80,
      ),
      color: Colors.red[400],
      onPressed: FuctionEle,
      direction: Axis.horizontal,
      isSelected: selectBool,
      children: selectTexto.map((e) => Text(e)).toList(),
    );
  }
}
