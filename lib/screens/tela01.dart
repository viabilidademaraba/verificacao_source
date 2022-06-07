import 'package:flutter/material.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'package:verificacao/widgets/button1.dart';
import 'package:verificacao/widgets/dialog.dart';

class Tela01 extends StatelessWidget {
  const Tela01({Key? key}) : super(key: key);

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
                    "UI Designer: Cristina Vitória",
                    style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.code, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(
                    "Programador: Isac Galvão",
                    style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.person, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(
                    "Idealizadora: Mireli Lima",
                    style: TextStyle(color: Colors.grey.withOpacity(0.5)),
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
