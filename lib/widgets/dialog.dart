import 'package:flutter/material.dart';
import 'package:verificacao/screens/tela02.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'package:verificacao/widgets/button2.dart';

class InitDialog extends StatelessWidget {
  const InitDialog({Key? key}) : super(key: key);

  final double borderRadius = 10;
  final double padding = 14.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 803,
        height: 600,
        decoration: BoxDecoration(
          color: HexColor("#252525"),
          border: Border.all(
            color: HexColor("#FBFEDC"),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close_rounded,
                  color: HexColor("#797979"),
                  size: 30,
                ),
              ),
            ),
            Text(
              "Realizar a verificação é simples, basta ter os seguintes dados do empreendimento e responder as questões:",
              style: TextStyle(color: HexColor("#F5FF84"), fontSize: 30),
            ),
            const SizedBox(height: 30),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      texto(
                          "Localização da área que se pretende instalar o empreendimento"),
                      SizedBox(height: padding),
                      texto("Atividades que se pretende instalar"),
                      SizedBox(height: padding),
                      texto("Área total do lote"),
                      SizedBox(height: padding),
                      texto("Curvas de nível da área"),
                      SizedBox(height: padding),
                      texto("Grau de Incomodidade"),
                      SizedBox(height: padding),
                      texto("Largura da via de acesso ao lote"),
                      SizedBox(height: padding),
                      texto("Coeficiente de Aproveitamento"),
                      SizedBox(height: padding),
                      texto("Taxa de Ocupação"),
                      SizedBox(height: padding),
                      texto("Taxa de Permeabilidade do Solo"),
                      SizedBox(height: padding),
                      texto("Recuos em relação aos limites do lote"),
                      SizedBox(height: padding),
                      texto("Largura da frente do lote"),
                      SizedBox(height: padding),
                      texto("Altura da edificação"),
                      SizedBox(height: padding),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Button2(
                  text: "OK",
                  size: 1.5,
                  callback: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => Tela02(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget texto(String text) {
    return Text(
      text,
      style: TextStyle(
        color: HexColor("#ECECEC"),
        fontSize: 18,
      ),
    );
  }
}
