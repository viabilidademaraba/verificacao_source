import 'package:flutter/material.dart';
import 'package:verificacao/screens/loading_screen.dart';
import 'package:verificacao/screens/sem_loc.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'package:verificacao/widgets/button1.dart';
import 'package:verificacao/widgets/button3.dart';
import 'package:verificacao/widgets/error_dialog.dart';
import 'package:verificacao/widgets/form_question.dart';

class Tela02 extends StatefulWidget {
  Tela02({Key? key}) : super(key: key);

  final pageController = PageController(initialPage: 0);
  var actual_page = 0;

  var respostas = {};
  var option1 = "";
  var option2 = "";

  @override
  State<Tela02> createState() => _Tela02State();
}

class _Tela02State extends State<Tela02> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: HexColor("#252525"),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Por favor, responda:",
              style: TextStyle(
                color: HexColor("#F8E436"),
                fontSize: 38,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: widget.pageController,
                children: List.generate(
                  perguntas().length,
                  (index) => FormQuestion(
                    pergunta: perguntas()[index],
                    question: perguntas()[index]["texto_apoio"] != null
                        ? true
                        : false,
                  ),
                ),
                onPageChanged: (page) => setState(
                  () => widget.actual_page = page,
                ),
              ),
            ),
            const Spacer(),
            botao()
          ],
        ),
      ),
    );
  }

  botao() {
    if (widget.actual_page == 0) {
      return proxima();
    } else if (widget.actual_page > 0 && widget.actual_page <= 1) {
      return anterior();
    } else if (widget.actual_page == 2) {
      return proxima();
    } else if (widget.actual_page > 2 &&
        widget.actual_page < perguntas().length - 1) {
      return anteriorProxima();
    } else {
      return anteriorFinalizar();
    }
  }

  Row anteriorProxima() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Button3(
          text: "Anterior",
          size: 1,
          callback: () {
            widget.pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
            );
          },
        ),
        Button1(
          text: "Pr??xima",
          size: 1,
          callback: () {
            final resposta = widget.respostas[widget.actual_page];
            if (resposta == -1 || resposta == "" || resposta == null) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                  message: "Por favor, preencha o campo!",
                ),
              );
            } else if (widget.actual_page == 10 &&
                widget.option2 == "" &&
                widget.respostas[widget.actual_page] ==
                    "Projetos de implanta????o, modifica????o, amplia????o ou regulariza????o de...") {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                  message: "Por favor, preencha o campo!",
                ),
              );
            } else {
              widget.pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCirc,
              );
            }
          },
        )
      ],
    );
  }

  Row anterior() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Button3(
          text: "Anterior",
          size: 1,
          callback: () {
            widget.pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCirc,
            );
          },
        )
      ],
    );
  }

  Row proxima() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Button1(
          text: "Pr??xima",
          size: 1,
          callback: () {
            final resposta = widget.respostas[widget.actual_page];
            if (resposta == -1 || resposta == "" || resposta == null) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                  message: "Por favor, preencha o campo!",
                ),
              );
            } else if (widget.actual_page == 2 &&
                widget.option1 == "" &&
                widget.respostas[widget.actual_page] ==
                    "Zona Urbana, em um dos N??cleos") {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                  message: "Por favor, preencha o campo!",
                ),
              );
            } else {
              widget.pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCirc,
              );
            }
          },
        )
      ],
    );
  }

  Row anteriorFinalizar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Button3(
          text: "Anterior",
          size: 1,
          callback: () {
            widget.pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
            );
          },
        ),
        Button1(
          text: "Finalizar",
          size: 1,
          callback: () {
            final resposta = widget.respostas[widget.actual_page];
            if (resposta == -1 || resposta == "" || resposta == null) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(
                  message: "Por favor, preencha o campo!",
                ),
              );
            } else {
              Map temp = widget.respostas;
              temp["option1"] = widget.option1;
              temp["option2"] = widget.option2;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoadingScreen(data: temp),
                ),
              );
            }
          },
        )
      ],
    );
  }

  onSubmitted(String value) {
    if (value.isEmpty || value == "0.00") {
      showDialog(
        context: context,
        builder: (_) => ErrorDialog(
          message: "Por favor, preencha o campo!",
        ),
      );
    } else {
      if (widget.actual_page >= perguntas().length - 1) {
        Map temp = widget.respostas;
        temp["option1"] = widget.option1;
        temp["option2"] = widget.option2;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoadingScreen(data: temp),
          ),
        );
      } else {
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCirc,
        );
      }
    }
  }

  perguntas() {
    return {
      0: {
        "titulo": "01 - Insira o nome do empreendimento:",
        "type": "escrever",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted
      },
      1: {
        "titulo": "02 - Possui a localiza????o do empreendimento?",
        "type": "button",
        "options": ["Sim", "N??o"],
        "callback": [
          () {
            widget.pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
            );
          },
          () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SemLocalizacao(),
              ),
            );
          }
        ]
      },
      2: {
        "titulo": "03 - Localiza????o:",
        "type": "selecionar_2",
        "options": [
          "Zona Urbana, em um dos N??cleos",
          "Zona Urbana, em uma Zona de Expans??o Urbana",
          "Zona Urbana, em uma Vila Sede",
          "Zona Rural, fora de uma Vila Sede"
        ],
        "options2": [
          "N??cleo Marab?? Pioneira",
          "N??cleo Cidade Nova",
          "N??cleo Nova Marab??",
          "N??cleo S??o F??lix",
          "N??cleo Morava Nova"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "callback2": (value) {
          widget.option1 = value;
        },
        "texto_apoio":
            "As Zonas Urbanas de Marab?? correspondem ao Distrito Sede Municipal e ??s Vilas Sede dos Distritos Rurais, enquanto que as Zonas Rurais s??o as ??reas dos Distritos Rurais fora das Vilas Sede, conforme apresentam os Mapas 02 e 04 do Plano Diretor.",
        "hasImagem": true,
        "imagens": ["assets/mapa02.jpg", "assets/mapa04.jpg"],
        "nome_imagem": ["Mapa 02", "Mapa 04"]
      },
      3: {
        "titulo": "04 - Setor de Uso:",
        "type": "selecionar",
        "options": [
          "Setor Consolidado",
          "Setor em Consolida????o",
          "Setor de Uso Controlado",
          "Setor de Recupera????o e Qualifica????o"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "O Zoneamento Municipal delimita os Setores de Uso considerando as caracter??sticas da ocupa????o do solo e a qualidade da infraestrutura, sendo definidos conforme o Mapa 03 do Plano Diretor.",
        "hasImagem": true,
        "imagens": ["assets/mapa03.jpg"],
        "nome_imagem": ["Mapa 03"]
      },
      4: {
        "titulo": "05 - Zona de Uso:",
        "type": "selecionar",
        "options": [
          "Zona Mista Residencial",
          "Zona Especial de Interesse Social",
          "Zona Especial de Interesse Ambiental",
          "Zona Especial de Prote????o do Patrim??nio Hist??rico",
          "Zona Especial de Seguran??a Alimentar",
          "Zona Especial Industrial",
          "Zona Especial de Com??rcio e Servi??os",
          "Zona Especial de Interesse Tur??stico",
          "Zona Especial de Interesse Urban??stico"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "O Zoneamento Municipal delimita as Zonas de Uso considerando os usos permitidos e os par??metros de ocupa????o do solo, sendo definidas conforme o Mapa 06 do Plano Diretor. ",
        "hasImagem": true,
        "imagens": ["assets/mapa06.jpg"],
        "nome_imagem": ["Mapa 06"]
      },
      5: {
        "titulo": "06 - O empreendimento se encontra em uma Zona de Outorga?",
        "type": "selecionar",
        "options": ["Sim", "N??o"],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "As Zonas de Outorga s??o as ??reas delimitadas pelo Mapa 05 do Plano Diretor e as ??reas correspondentes aos Setores Consolidados, delimitados pelo Mapa 03 (exceto no N??cleo Marab?? Pioneira e fora do Distrito Sede Municipal).",
        "hasImagem": true,
        "imagens": ["assets/mapa03.jpg", "assets/mapa05.jpg"],
        "nome_imagem": ["Mapa 03", "Mapa 05"]
      },
      6: {
        "titulo": "07 - Classifica????o do Uso do Solo:",
        "type": "selecionar",
        "options": [
          "Residencial Unifamiliar",
          "Residencial Multifamiliar",
          "Comercial",
          "Institucional",
          "Presta????o de servi??os",
          "Industrial",
          "Misto",
          "Rural",
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "O uso residencial ?? destinado somente ?? moradia. O uso n??o-residencial envolve as atividades de produ????o industrial, com??rcio em geral, presta????o de servi??os, atividades institucionais, atividades agr??colas e pecu??rias. O uso misto ?? quando na mesma edifica????o existe o uso residencial e n??o-residencial.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      7: {
        "titulo": "08 - Atividades que se pretendem instalar:",
        "type": "escrever",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "Elenque as atividades residenciais, n??o-residenciais ou mistas que se pretende instalar no empreendimento. Por exemplo: venda por atacado/varejo; produ????o de ferro-gusa; servi??os de hotelaria; revenda de combust??veis; Esta????o de R??dio Base; transportadora; galp??o de armazenamento; etc.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      8: {
        "titulo": "09 - Grau de Incomodidade:",
        "type": "selecionar",
        "options": [
          "Grau 1 - Baix??ssimo",
          "Grau 2 - Baixo",
          "Grau 3 - M??dio",
          "Grau 4 - Alto",
          "Grau 5 - Alt??ssimo",
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "?? um par??metro que indica a capacidade de uma atividade de gerar inc??modos relacionados ?? polui????o ambiental e que estabelece a localiza????o que tal atividade pode ser instalada. Os Graus de Incomodidade v??o de 1 a 5, sendo:\n\nGrau 1 ??? Baix??ssimo: A sua capacidade de gerar inc??modos, polui????o e nocividade a popula????o, fauna e flora ?? consideravelmente baix??ssima, podendo localizar-se na macrozona estritamente residencial urbana, ou de hospitais ou de escolas;\n\nGrau 2 ??? Baixo: A sua capacidade de gerar inc??modos, polui????o e nocividade a popula????o, fauna e flora ?? consideravelmente baixa, podendo localizar-se na macrozona em ??rea mista, predominantemente residencial;\n\nGrau 3 ??? M??dio: A sua capacidade de gerar inc??modos, polui????o e nocividade a popula????o, fauna e flora ?? consideravelmente m??dia, devendo assim instalar-se nos principais corredores de tr??fego da zona urbana, respeitando assim as legisla????es e normas municipais, estaduais e federais;\n\nGrau 4 ??? Alto: A sua capacidade de gerar inc??modos, polui????o e nocividade a popula????o, fauna e flora ?? consideravelmente alta, devendo assim instalar-se nas Zonas de Expans??o da Cidade Nova, Zona de Expans??o da Nova Marab?? e Zonas Especiais Industriais, respeitando assim as legisla????es e normas municipais, estaduais e federais;\n\nGrau 5 ??? Alt??ssimo: A sua capacidade de gerar inc??modos, polui????o e nocividade a popula????o, fauna e flora ?? consideravelmente alta, devendo assim instalar-se nas Zonas Especiais Industriais e Zona Rural, respeitando assim as legisla????es e normas municipais, estaduais e federais.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      9: {
        "titulo":
            "10 - Classifica????o das atividades quanto aos Usos Geradores de Interfer??ncia no Tr??fego:",
        "type": "selecionar",
        "options": [
          "Geradoras de carga e descarga",
          "Geradoras de embarque e desembarque",
          "Geradoras de tr??fego de pedestres",
          "Geradoras de viagens",
          "Nenhuma das anteriores ",
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "Para qualquer dessas atividades, o empreendimento ?? considerado como Uso Gerador de Interfer??ncia no Tr??fego.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      10: {
        "titulo":
            "11 - Sabendo que o empreendimento ?? considerado como Uso Gerador de Impacto ?? Vizinhan??a, em qual dos casos ele se encaixa?",
        "type": "selecionar_2",
        "options": [
          "Projetos de implanta????o, modifica????o, amplia????o ou regulariza????o de...",
          "Parcelamento do solo em glebas urbanas",
          "Empreendimentos de car??ter urbano a serem estabelecidos na ??rea rural ou em ??reas de urbaniza????o espec??fica",
          "Demais casos previstos em lei espec??fica",
        ],
        "options2": [
          "os empreendimentos residenciais com mais de 100 unidade habitacionais ou quando situadas em terrenos com ??rea igual ou superior a 10.000 m??",
          "esta????es, terminais e edifica????es de suporte dos sistemas rodovi??rio urbano, intermunicipal e interestadual, ferrovi??rio, metrovi??rio, aquavi??rio e similares, com ??rea constru??da superior a 750m??",
          "garagens de ve??culos de transporte de passageiros",
          "os estabelecimentos de ensino, pesquisa e extens??o, com ??rea constru??da igual ou superior a 2.000m??, com no m??nimo 600 alunos por turno ou per??odo",
          "centros comerciais, shoppings centers, supermercados e hipermercados com ??rea constru??da igual ou superior a 2.000m??",
          "estabelecimentos de sa??de como hospitais, centros de sa??de, cl??nicas e similares com ??rea constru??da igual ou superior a 2.000m??, com capacidade igual ou superior a 200 leitos simultaneamente",
          "hot??is, pens??es, pousadas, com ??rea superior a 2.000 m??",
          "cemit??rios e cremat??rios",
          "gin??sios, est??dios, hip??dromos, h??picas, centros e complexos esportivos",
          "aut??dromos, kart??dromos e similares",
          "centrais de cargas, log??stica, abastecimento e transportadoras",
          "pres??dios, complexos prisionais, centro de reabilita????o de menores e similares",
          "casas noturnas, casas de show e similares",
          "Parque agropecu??rio, parque de divers??o, samb??dromo e similares",
          "Zool??gico, jardim bot??nico e similares",
          "estacionamentos em superf??cie estabelecidos em lotes com uso exclusivo para este fim, para qualquer tipo de ve??culo e administrados por empresa regulamentada",
          "portos, aeroportos, aer??dromos, heliportos e similares",
          "postos de abastecimento de combust??veis",
          "dep??sitos de g??s liquefeito de petr??leo",
          "dep??sito de inflam??veis, t??xicos e equipar??veis",
          "esta????es de tratamento",
          "esta????o de r??dio base",
          "condom??nios",
          "atividades de alto ou alt??ssimo n??vel de incomodidade",
          "demais atividades ou empreendimentos n??o residenciais com ??rea constru??da igual ou superior a 3.000m??"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "callback2": (value) {
          widget.option2 = value;
        },
        "texto_apoio":
            "Os Usos Geradores de Impacto ?? Vizinhan??a s??o todos aqueles que possam vir a causar altera????o significativa no ambiente natural ou constru??do, ou sobrecarga na capacidade de atendimento da infraestrutura b??sica, listados no Art. 146 da Lei Municipal N?? 17.846/2018 (Plano Diretor Participativo de Marab??).",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      11: {
        "titulo": "12 - Qual a ??rea total do lote, em metros quadrados?",
        "type": "escrever_numero",
        "unidade": "m??",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a ??rea total, em metros quadrados, constada no documento do terreno.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      12: {
        "titulo": "13 - Qual a menor cota altim??trica da ??rea, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "Cotas altim??tricas s??o medidas, em metros, da altura do terreno, geralmente aferidas por um levantamento planialtim??trico.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      13: {
        "titulo": "14 - Qual o Coeficiente de Aproveitamento da edifica????o?",
        "type": "escrever_numero",
        "unidade": "",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a rela????o entre o total das ??reas constru??das e a ??rea do terreno em que se implantar?? a edifica????o (CA = AC/AT). N??o s??o computadas no c??lculo as ??reas de: subsolos para estacionamento; pavimentos sob pilotis quando abertos e livres no m??nimo em 70% de sua ??rea; equipamentos de lazer no n??vel do terreno ou cobertura, exceto para empreendimentos de lazer; estacionamento de ve??culos, exceto para edif??cios garagem ou estacionamento de uso comercial; casas de m??quinas, caixas d?????gua, centrais de ar condicionado, antenas de sinaliza????o; sacadas privativas, desde que n??o vinculadas ??s depend??ncias de servi??o e com ??rea inferior a 5% do pavimento.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      14: {
        "titulo": "15 - Qual a Taxa de Ocupa????o da edifica????o, em porcentagem?",
        "type": "escrever_numero",
        "unidade": "%",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a rela????o entre a proje????o horizontal da ??rea constru??da e a ??rea do terreno (TO = PAC x 100 / AT). N??o s??o computadas no c??lculo as ??reas de: equipamentos de lazer no n??vel do terreno ou cobertura, exceto para empreendimentos de lazer; estacionamento de ve??culos, exceto para uso comercial; pergolados at?? 4 m de largura; marquises; beirais de at?? 1,2 m; sacadas e balc??es de at?? 1,2 m em balan??o e com ??rea inferior a 5% da superf??cie do pavimento.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      15: {
        "titulo": "16 - Qual a Taxa de Permeabilidade do Solo, em porcentagem?",
        "type": "escrever_numero",
        "unidade": "%",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "Corresponde ao percentual m??nimo da ??rea do terreno que deve permanecer perme??vel.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      16: {
        "titulo": "17 - Qual o recuo frontal da edifica????o, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, do limite frontal do terreno at?? a edifica????o.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      17: {
        "titulo": "18 - Qual o recuo de fundo da edifica????o, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, do limite do fundo do terreno at?? a edifica????o.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      18: {
        "titulo":
            "19 - Qual o recuo da lateral direita da edifica????o, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, do limite da lateral direita do terreno at?? a edifica????o.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      19: {
        "titulo":
            "20 - Qual o recuo da lateral esquerda da edifica????o, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, do limite da lateral esquerda do terreno at?? a edifica????o.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      20: {
        "titulo":
            "21 - Qual o recuo da lateral de esquina da edifica????o, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, do limite da lateral de esquina do terreno at?? a edifica????o.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      21: {
        "titulo": "22 - Qual a altura da edifica????o, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, do n??vel do terreno at?? a maior altura da edifica????o.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      22: {
        "titulo": "23 - Qual a largura da frente do lote, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, dos limites laterais da frente do terreno.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      23: {
        "titulo": "24 - Qual a largura da via de acesso ao lote, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "?? a dist??ncia, em metros, dos limites laterais da faixa transit??vel da via de acesso ao terreno.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
    };
  }
}
