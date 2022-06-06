import 'package:flutter/material.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'package:verificacao/widgets/button2.dart';

class ErrorDialog extends StatelessWidget {
  var message;

  ErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 500,
        height: 150,
        decoration: BoxDecoration(
          color: HexColor("#252525"),
          border: Border.all(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.red.withOpacity(0.8),
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Button2(
                text: "OK",
                size: 1,
                callback: () => Navigator.of(context).pop(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
