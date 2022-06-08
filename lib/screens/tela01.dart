import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'package:verificacao/widgets/button1.dart';
import 'package:verificacao/widgets/dialog.dart';

class Tela01 extends StatefulWidget {
  Tela01({Key? key}) : super(key: key);

  bool _hover1 = false;
  bool _hover2 = false;
  bool _hover3 = false;

  @override
  State<Tela01> createState() => _Tela01State();
}

class _Tela01State extends State<Tela01> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: HexColor("#252525"),
      child: Stack(
        children: [
          Positioned(
            right: 1,
            child: Image.asset(
              'assets/estado.png',
              width: 832,
              height: 720,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 154, left: 61),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        "Verificação Prévia do Plano Diretor de Marabá",
                        style: TextStyle(
                          fontSize: 38,
                          color: HexColor("#F5FF84"),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Este site foi criado a partir de um Trabalho de Conclusão de Curso para que qualquer pessoa possa realizar uma verificação prévia da viabilidade de se instalar um empreendimento de impacto segundo o Plano Diretor de Marabá.",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 74),
                      Button1(
                        text: "Iniciar",
                        size: 2,
                        callback: () {
                          showDialog(
                            context: context,
                            builder: (context) => const InitDialog(),
                          );
                        },
                      ),
                      const Spacer(),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Expanded(child: Container(), flex: 2),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Icon(Icons.design_services,
                      color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(
                    "UI Designer: ",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse(
                          "https://www.linkedin.com/in/cristina-leite-493595166/"),
                    ),
                    onHover: (value) => setState(() => widget._hover1 = value),
                    child: Text(
                      "Cristina Leite",
                      style: TextStyle(
                        color: widget._hover1
                            ? Colors.white
                            : Colors.grey.withOpacity(0.5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.code, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(
                    "Programador: ",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse(
                          "https://www.linkedin.com/in/isac-galv%C3%A3o-9b974114a"),
                    ),
                    onHover: (value) => setState(() => widget._hover2 = value),
                    child: Text(
                      "Isac Galvão",
                      style: TextStyle(
                        color: widget._hover2
                            ? Colors.white
                            : Colors.grey.withOpacity(0.5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.person, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(
                    "Idealizadora: ",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse(
                          'https://www.linkedin.com/in/mireli-lima-079a30159/'),
                    ),
                    onHover: (value) => setState(() => widget._hover3 = value),
                    child: Text(
                      "Mireli Lima",
                      style: TextStyle(
                        color: widget._hover3
                            ? Colors.white
                            : Colors.grey.withOpacity(0.5),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Versão 1.0",
                    style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
