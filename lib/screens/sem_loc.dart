import 'package:flutter/material.dart';
import 'package:verificacao/screens/tela01.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'dart:math' as math;

class SemLocalizacao extends StatelessWidget {
  const SemLocalizacao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HexColor("#252525"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Transform.rotate(
            angle: -math.pi / 4,
            child: Icon(
              Icons.add_circle_outline_sharp,
              color: HexColor("#F91C1C"),
              size: 250,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "Sem a localização do empreendimento não é possível realizar a verificação",
            style: TextStyle(color: HexColor("#F91C1C"), fontSize: 36),
          ),
          const Spacer(),
          SizedBox(
            height: 60,
            width: 300,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Tela01(),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "Voltar ao início",
                    style: TextStyle(
                      fontSize: 24,
                      color: HexColor("#252525"),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              ),
              style: ElevatedButton.styleFrom(
                primary: HexColor("##EEFE31"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
