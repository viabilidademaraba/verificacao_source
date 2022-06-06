import 'package:flutter/material.dart';
import 'package:verificacao/utils/hexcolor.dart';

class FormButton extends StatelessWidget {
  FormButton(
      {Key? key,
      required this.text,
      required this.preenchido,
      required this.callback})
      : super(key: key);

  final text;
  final preenchido;
  VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: preenchido ? Colors.black : HexColor("#F6CD3B"),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: preenchido ? HexColor("#F6CD3B") : HexColor("#383838"),
        side: BorderSide(
          width: 1,
          color: HexColor("#F6CD3B"),
        ),
      ),
    );
  }
}
