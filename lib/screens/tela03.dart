import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:verificacao/analise.dart';
import 'package:verificacao/screens/tela01.dart';
import 'package:verificacao/utils/download.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'dart:math' as math;

class Tela03 extends StatefulWidget {
  Map data;
  bool darkTheme = true;
  var controller = ScreenshotController();

  Tela03({Key? key, required this.data}) : super(key: key);

  @override
  State<Tela03> createState() => _Tela03State();
}

class _Tela03State extends State<Tela03> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.darkTheme ? HexColor("#252525") : Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40),
              child: header(context),
            ),
            Screenshot(
              controller: widget.controller,
              child: Container(
                color: widget.darkTheme ? HexColor("#252525") : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      resultado(widget.data)
                          ? Icon(
                              Icons.check_circle_outline_rounded,
                              color: HexColor("#5DC03A"),
                              size: 250,
                            )
                          : Transform.rotate(
                              angle: -math.pi / 4,
                              child: Icon(
                                Icons.add_circle_outline_sharp,
                                color: HexColor("#F91C1C"),
                                size: 250,
                              ),
                            ),
                      Texto(
                        text: resultado(widget.data)
                            ? "A instala????o do seu empreendimento ?? vi??vel"
                            : "A instala????o do seu empreendimento n??o ?? vi??vel",
                        color: resultado(widget.data)
                            ? HexColor("#5DC03A")
                            : HexColor("#F91C1C"),
                        fontSize: 36,
                      ),
                      const SizedBox(height: 22),
                      Texto(
                        text: resultado(widget.data)
                            ? "A partir das respostas inseridas nesta verifica????o pr??via, o empreendimento se mostrou adequado ao Plano Diretor de Marab??. Solicite as Diretrizes Urban??sticas junto ao Conselho Gestor do Plano Diretor para que seja feita a verifica????o completa."
                            : "A partir das respostas inseridas nesta verifica????o pr??via, o empreendimento se mostrou inadequado ao Plano Diretor de Marab??. Solicite as Diretrizes Urban??sticas junto ao Conselho Gestor do Plano Diretor para que seja feita a verifica????o completa.",
                        color: HexColor("#686868"),
                        fontSize: 24,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 84),
                      questaoGenerica(
                          "O nome de identifica????o do empreendimento ??:",
                          widget.data[0]),
                      questaoGenerica(
                          "A localiza????o do empreendimento ??:",
                          widget.data["option1"] != ""
                              ? "${widget.data[2]}: ${widget.data["option1"]}"
                              : widget.data[2]),
                      questaoGenerica(
                          "O Setor de Uso da localiza????o do empreendimento ??:",
                          widget.data[3]),
                      questaoGenerica(
                        "A Zona de Uso da localiza????o do empreendimento ??:",
                        resultadoZona(widget.data[4]),
                      ),
                      questaoGenerica(
                          "A classifica????o do uso do solo do empreendimento ??:",
                          resultadoUso(
                              widget.data[4], widget.data[6], widget.data[2])),
                      questaoGenerica(
                          "As atividades que se pretende instalar no empreendimento s??o:",
                          widget.data[7]),
                      questaoGenerica(
                          "A classifica????o do empreendimento quanto aos Usos Geradores de Interfer??ncia no Tr??fego ??:",
                          widget.data[9]),
                      questaoGenerica(
                          "A classifica????o do empreendimento quanto aos Usos Geradores de Impacto de Vizinhan??a ??:",
                          widget.data["option2"] != ""
                              ? "${widget.data[10]} ${widget.data["option2"]}"
                              : widget.data[10]),
                      const SizedBox(height: 52),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Texto(
                          text:
                              "Os resultados da verifica????o dos par??metros urban??sticos do empreendimento foram:",
                          color: HexColor("#7C7C7C"),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 29),
                      WContainer(
                        darkTheme: widget.darkTheme,
                        child: Column(
                          children: [
                            parametro([
                              true,
                              "A ??rea total do lote ?? ${widget.data[11]} m??"
                            ]),
                            parametro(getCotaAltimetrica(
                                double.parse(widget.data[12]))),
                            parametro(getCoeficienteAproveitamento(
                                double.parse(widget.data[13]),
                                widget.data[5],
                                widget.data["option1"])),
                            parametro(getTaxaOcupacao(
                                double.parse(widget.data[14]),
                                widget.data[3],
                                widget.data[6],
                                widget.data[2])),
                            parametro(getTaxaPermeabilidade(
                                double.parse(widget.data[15]))),
                            parametro(getRecuoFrontal(
                                double.parse(widget.data[16]),
                                widget.data[3],
                                widget.data[6],
                                widget.data[2])),
                            parametro(getRecuoFundo(
                                double.parse(widget.data[17]),
                                widget.data[3],
                                widget.data[6],
                                widget.data[2])),
                            parametro(getRecuoLateralDireita(
                                double.parse(widget.data[18]),
                                widget.data[3],
                                widget.data[6],
                                widget.data[2])),
                            parametro(getRecuoLateralEsquerda(
                                double.parse(widget.data[19]), widget.data[6])),
                            parametro(getRecuoLateralEsquina(
                                double.parse(widget.data[20]),
                                widget.data[3],
                                widget.data[6],
                                widget.data[2])),
                            parametro(getAlturaEdificacao(
                                double.parse(widget.data[21]),
                                double.parse(widget.data[23]),
                                double.parse(widget.data[16]))),
                            parametro(getLarguraFrente(
                                double.parse(widget.data[22]),
                                widget.data[3],
                                widget.data[6],
                                widget.data[2]))
                          ],
                        ),
                      ),
                      const SizedBox(height: 42),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Texto(
                          text:
                              "O Grau de Incomodidade do seu empreendimento ?? ${widget.data[8].substring(5, 6)}, os requisitos que voc?? deve cumprir s??o:",
                          fontSize: 24,
                          color: HexColor("#7C7C7C"),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Table(
                        border: TableBorder.all(
                          borderRadius: BorderRadius.circular(16),
                          color: HexColor("#7C7C7C"),
                          width: 2,
                        ),
                        children: [
                          TableRow(
                            children: [
                              Celula(
                                text: "Grau de Incomodidade",
                                fontWeight: FontWeight.bold,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: "Localiza????o",
                                fontWeight: FontWeight.bold,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: "Polui????o sonora",
                                fontWeight: FontWeight.bold,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: "Polu??c??o Atmosf??rica",
                                fontWeight: FontWeight.bold,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: "Polu??c??o H??drica",
                                fontWeight: FontWeight.bold,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: "Gera????o de res??duos",
                                fontWeight: FontWeight.bold,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: "Vibra????o",
                                fontWeight: FontWeight.bold,
                                darkTheme: widget.darkTheme,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Celula(
                                text: getGrauIncomodidade(widget.data[8]),
                                fontWeight: FontWeight.normal,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: getLocalizacao(widget.data[8]),
                                fontWeight: FontWeight.normal,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: getPoluicaoSonora(widget.data[8]),
                                fontWeight: FontWeight.normal,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: getPoluicaoAtmosferica(widget.data[8]),
                                fontWeight: FontWeight.normal,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: getPoluicaoHidrica(widget.data[8]),
                                fontWeight: FontWeight.normal,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: getGeracaoDeResiduos(widget.data[8]),
                                fontWeight: FontWeight.normal,
                                darkTheme: widget.darkTheme,
                              ),
                              Celula(
                                text: getVibracao(widget.data[8]),
                                fontWeight: FontWeight.normal,
                                darkTheme: widget.darkTheme,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 52),
                      Texto(
                        text: "Observa????es:",
                        color: HexColor("#7C7C7C"),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Texto(
                          text:
                              "O Plano Diretor Participativo de Marab?? pro??be o parcelamento do solo em cinco situa????es. Ser?? permitido o parcelamento se a ??rea pretendida para se instalar o empreendimento n??o apresentar os seguintes casos:",
                          color: widget.darkTheme
                              ? HexColor("#B8B8B8")
                              : HexColor("#444444"),
                          fontSize: 18,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(height: 32),
                      WContainer(
                        darkTheme: widget.darkTheme,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Texto(
                              text:
                                  "I - Em terrenos alagadi??os e sujeitos a inunda????es, antes de tomadas as providencias para assegurar o escoamento das ??guas;",
                              color: widget.darkTheme
                                  ? HexColor("#B8B8B8")
                                  : HexColor("#444444"),
                              fontSize: 18,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Texto(
                              text:
                                  "II - Em terrenos que tenham sido aterrados com material nocivo a sa??de p??blica, sem que sejam previamente saneados;",
                              color: widget.darkTheme
                                  ? HexColor("#B8B8B8")
                                  : HexColor("#444444"),
                              fontSize: 18,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Texto(
                              text:
                                  "III - Em terrenos com declividade igual ou superior a 30% (trinta por cento), salvos se atendidas as exig??ncias espec??ficas das autoridades competentes;",
                              color: widget.darkTheme
                                  ? HexColor("#B8B8B8")
                                  : HexColor("#444444"),
                              fontSize: 18,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Texto(
                              text:
                                  "IV - Em terrenos onde as condi????es geol??gicas n??o aconselhem a edifica????o;",
                              color: widget.darkTheme
                                  ? HexColor("#B8B8B8")
                                  : HexColor("#444444"),
                              fontSize: 18,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Texto(
                              text:
                                  "V - Em ??reas de preserva????o ecol??gica ou naquelas onde a polui????o impe??a condi????es sanit??rias suport??veis, at?? a sua corre????o.",
                              color: widget.darkTheme
                                  ? HexColor("#B8B8B8")
                                  : HexColor("#444444"),
                              fontSize: 18,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Texto(
                          text:
                              "Os empreendimentos enquadrados como Usos Geradores de Interfer??ncia no Tr??fego dever??o apresentar a previs??o de vagas de estacionamento em conformidade com a Lei Municipal N?? 17.873/2018, bem como as medidas de mitiga????o dos impactos atrav??s do Estudo Pr??vio de Impacto de Vizinhan??a e do Estudo de Interfer??ncia de Tr??fego.",
                          color: widget.darkTheme
                              ? HexColor("#B8B8B8")
                              : HexColor("#444444"),
                          textAlign: TextAlign.justify,
                          fontSize: 18,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Texto(
                          text:
                              "Os empreendimentos enquadrados como Usos Geradores de Impacto ?? Vizinhan??a s?? ter??o seu licenciamento junto ao Poder P??blico Municipal ap??s serem aprovados pelo Conselho Gestor do Plano Diretor (CGPD).",
                          color: widget.darkTheme
                              ? HexColor("#B8B8B8")
                              : HexColor("#444444"),
                          textAlign: TextAlign.justify,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile parametro(texto) {
    return ListTile(
      leading: Icon(
        texto[0] == true ? Icons.check : Icons.close,
        color: texto[0] == true
            ? widget.darkTheme
                ? HexColor("#5DC03A")
                : HexColor("#289B00")
            : HexColor("#F91C1C"),
      ),
      title: Texto(
        color: texto[0] == true
            ? widget.darkTheme
                ? HexColor("#5DC03A")
                : HexColor("#289B00")
            : HexColor("#F91C1C"),
        fontSize: 18,
        text: texto[1],
      ),
    );
  }

  header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.mode_night,
          color: widget.darkTheme ? Colors.white : Colors.black,
        ),
        Switch(
          value: widget.darkTheme,
          onChanged: (value) => setState(() => widget.darkTheme = value),
          activeColor: Colors.white,
        ),
        const SizedBox(width: 50),
        Botao(
          text: "Refazer relat??rio",
          icon: Icons.replay_rounded,
          callback: () => _refazerRelatorioAction(context),
          preenchido: false,
          darkTheme: widget.darkTheme,
        ),
        const SizedBox(width: 50),
        Botao(
          text: "Baixar",
          icon: Icons.file_download_outlined,
          callback: () async {
            final image = await widget.controller.capture(
              pixelRatio: 2480 / 1920,
            );

            download(image!,
                downloadName: "Verifica????o - ${widget.data[0]}.png");
          },
          preenchido: true,
          darkTheme: widget.darkTheme,
        )
      ],
    );
  }

  _refazerRelatorioAction(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Tela01(),
      ),
    );
  }

  questaoGenerica(titulo, texto) {
    return Column(
      children: [
        const SizedBox(height: 52),
        Align(
          alignment: Alignment.centerLeft,
          child: Texto(
            text: titulo,
            fontSize: 24,
            color: HexColor("#7C7C7C"),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 29),
        WContainer(
          darkTheme: widget.darkTheme,
          child: Texto(
            text: texto,
            color: texto.contains("n??o")
                ? HexColor("#F91C1C")
                : widget.darkTheme
                    ? HexColor("#B8B8B8")
                    : HexColor("#444444"),
            fontSize: 18,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}

class Celula extends StatelessWidget {
  Celula(
      {Key? key,
      required this.text,
      required this.fontWeight,
      required this.darkTheme})
      : super(key: key);

  bool darkTheme;
  final text;
  final fontWeight;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          text,
          style: TextStyle(
            color: darkTheme ? HexColor("#9C9A9A") : HexColor("#444444"),
            fontSize: 18,
            fontWeight: fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class WContainer extends StatelessWidget {
  bool darkTheme;

  WContainer({Key? key, required this.child, required this.darkTheme})
      : super(key: key);

  final child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkTheme ? HexColor("#383838") : HexColor("#BFBFBF"),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}

class Texto extends StatelessWidget {
  const Texto(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.color,
      this.textAlign = TextAlign.start,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  final text;
  final fontSize;
  final color;
  final fontWeight;
  final textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}

class Botao extends StatelessWidget {
  const Botao(
      {Key? key,
      required this.text,
      required this.icon,
      required this.callback,
      required this.preenchido,
      required this.darkTheme})
      : super(key: key);

  final text;
  final icon;
  final callback;
  final preenchido;
  final darkTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          primary: preenchido
              ? HexColor("#090808")
              : darkTheme
                  ? HexColor("#252525")
                  : Colors.white,
          side: BorderSide(
            width: 1,
            color: preenchido
                ? Colors.transparent
                : darkTheme
                    ? Colors.grey.withOpacity(0.8)
                    : Colors.black,
          ),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: HexColor("#A1A1A1"),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              icon,
              color: HexColor("#A1A1A1"),
            )
          ],
        ),
      ),
    );
  }
}
