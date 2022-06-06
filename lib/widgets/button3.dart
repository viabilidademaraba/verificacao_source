import 'package:flutter/material.dart';
import 'package:verificacao/utils/hexcolor.dart';

class Button3 extends StatelessWidget {
  Button3({
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
            Icon(
              Icons.arrow_back_rounded,
              color: HexColor("#252525"),
              size: 24 * size,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 14 * size,
                color: HexColor("#252525"),
                fontWeight: FontWeight.bold,
              ),
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
