import 'package:flutter/material.dart';
import 'package:verificacao/utils/hexcolor.dart';

class Button1 extends StatelessWidget {
  Button1({
    Key? key,
    required this.text,
    required this.size,
    required this.callback,
  }) : super(key: key);
  String text = "text";
  double size = 1;
  VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200 * size,
      height: 40 * size,
      child: ElevatedButton(
        onPressed: callback,
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14 * size,
                color: HexColor("#252525"),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_rounded,
              color: HexColor("#252525"),
              size: 24 * size,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: HexColor("#F8E436"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
