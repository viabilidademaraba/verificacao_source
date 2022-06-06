import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:verificacao/screens/tela03.dart';
import 'package:verificacao/utils/hexcolor.dart';

class LoadingScreen extends StatefulWidget {
  Map data;

  LoadingScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 10, milliseconds: 500),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Tela03(data: widget.data),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var defaultStyle = TextStyle(
      color: HexColor("#F8E436"),
      fontSize: 64,
      fontWeight: FontWeight.normal,
    );
    return Material(
      color: HexColor("#252525"),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              colors: [HexColor("#F8E436")],
              strokeWidth: 2,
            ),
          ),
          const SizedBox.square(dimension: 100),
          AnimatedTextKit(
            pause: Duration.zero,
            totalRepeatCount: 1,
            animatedTexts: [
              RotateAnimatedText(
                "Calculando tudo pra você :)",
                textStyle: defaultStyle,
                duration: const Duration(seconds: 4),
              ),
              RotateAnimatedText(
                "Verificando viabilidade...",
                textStyle: defaultStyle,
                duration: const Duration(seconds: 4),
              ),
              RotateAnimatedText(
                "Tudo pronto!",
                textStyle: defaultStyle,
                rotateOut: false,
                duration: const Duration(milliseconds: 500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
