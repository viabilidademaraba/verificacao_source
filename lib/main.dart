import 'package:flutter/material.dart';
import 'package:verificacao/screens/tela01.dart';
import 'utils/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*var mock = {
      0: "Mirelikkk",
      2: "Zona Urbana, em um dos Núcleos",
      3: "Setor Consolidado",
      4: "Zona de Segurança do Aeroporto",
      5: "Sim",
      6: "Residencial Multifamiliar",
      7: "asofmasof",
      8: "Grau 2 - Baixo",
      9: "Geradoras de carga e descarga",
      10: "Projetos de implantação, modificação, ampliação ou regularização de...",
      11: "1.23",
      12: "3.21",
      13: "2.34",
      14: "4.32",
      15: "3.45",
      16: "5.43",
      17: "4.56",
      18: "6.54",
      19: "5.67",
      20: "7.65",
      21: "6.78",
      22: "8.76",
      23: "7.89",
      "option1": "Núcleo Cidade Nova",
      "option2":
          "os empreendimentos residenciais com mais de 100 unidade habitacionais ou quando situadas em terrenos com área igual ou superior a 10.000 m²"
    };*/
    return MaterialApp(
      title: "Viabilidade Marabá",
      debugShowCheckedModeBanner: false,
      home: const Tela01(),
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(
            HexColor("#5F5B5B"),
          ),
        ),
      ),
    );
  }
}
