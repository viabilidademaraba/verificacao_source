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
          text: "Próxima",
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
                    "Projetos de implantação, modificação, ampliação ou regularização de...") {
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
          text: "Próxima",
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
                    "Zona Urbana, em um dos Núcleos") {
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
        "titulo": "02 - Possui a localização do empreendimento?",
        "type": "button",
        "options": ["Sim", "Não"],
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
        "titulo": "03 - Localização:",
        "type": "selecionar_2",
        "options": [
          "Zona Urbana, em um dos Núcleos",
          "Zona Urbana, em uma Zona de Expansão Urbana",
          "Zona Urbana, em uma Vila Sede",
          "Zona Rural, fora de uma Vila Sede"
        ],
        "options2": [
          "Núcleo Marabá Pioneira",
          "Núcleo Cidade Nova",
          "Núcleo Nova Marabá",
          "Núcleo São Félix",
          "Núcleo Morava Nova"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "callback2": (value) {
          widget.option1 = value;
        },
        "texto_apoio":
            "As Zonas Urbanas de Marabá correspondem ao Distrito Sede Municipal e às Vilas Sede dos Distritos Rurais, enquanto que as Zonas Rurais são as áreas dos Distritos Rurais fora das Vilas Sede, conforme apresentam os Mapas 02 e 04 do Plano Diretor.",
        "hasImagem": true,
        "imagens": ["assets/mapa02.jpg", "assets/mapa04.jpg"],
        "nome_imagem": ["Mapa 02", "Mapa 04"]
      },
      3: {
        "titulo": "04 - Setor de Uso:",
        "type": "selecionar",
        "options": [
          "Setor Consolidado",
          "Setor em Consolidação",
          "Setor de Uso Controlado",
          "Setor de Recuperação e Qualificação"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "O Zoneamento Municipal delimita os Setores de Uso considerando as características da ocupação do solo e a qualidade da infraestrutura, sendo definidos conforme o Mapa 03 do Plano Diretor.",
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
          "Zona Especial de Proteção do Patrimônio Histórico",
          "Zona Especial de Segurança Alimentar",
          "Zona Especial Industrial",
          "Zona Especial de Comércio e Serviços",
          "Zona Especial de Interesse Turístico",
          "Zona Especial de Interesse Urbanístico"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "O Zoneamento Municipal delimita as Zonas de Uso considerando os usos permitidos e os parâmetros de ocupação do solo, sendo definidas conforme o Mapa 06 do Plano Diretor. ",
        "hasImagem": true,
        "imagens": ["assets/mapa06.jpg"],
        "nome_imagem": ["Mapa 06"]
      },
      5: {
        "titulo": "06 - O empreendimento se encontra em uma Zona de Outorga?",
        "type": "selecionar",
        "options": ["Sim", "Não"],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "As Zonas de Outorga são as áreas delimitadas pelo Mapa 05 do Plano Diretor e as áreas correspondentes aos Setores Consolidados, delimitados pelo Mapa 03 (exceto no Núcleo Marabá Pioneira e fora do Distrito Sede Municipal).",
        "hasImagem": true,
        "imagens": ["assets/mapa03.jpg", "assets/mapa05.jpg"],
        "nome_imagem": ["Mapa 03", "Mapa 05"]
      },
      6: {
        "titulo": "07 - Classificação do Uso do Solo:",
        "type": "selecionar",
        "options": [
          "Residencial Unifamiliar",
          "Residencial Multifamiliar",
          "Comercial",
          "Institucional",
          "Prestação de serviços",
          "Industrial",
          "Misto",
          "Rural",
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "O uso residencial é destinado somente à moradia. O uso não-residencial envolve as atividades de produção industrial, comércio em geral, prestação de serviços, atividades institucionais, atividades agrícolas e pecuárias. O uso misto é quando na mesma edificação existe o uso residencial e não-residencial.",
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
            "Elenque as atividades residenciais, não-residenciais ou mistas que se pretende instalar no empreendimento. Por exemplo: venda por atacado/varejo; produção de ferro-gusa; serviços de hotelaria; revenda de combustíveis; Estação de Rádio Base; transportadora; galpão de armazenamento; etc.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      8: {
        "titulo": "09 - Grau de Incomodidade:",
        "type": "selecionar",
        "options": [
          "Grau 1 - Baixíssimo",
          "Grau 2 - Baixo",
          "Grau 3 - Médio",
          "Grau 4 - Alto",
          "Grau 5 - Altíssimo",
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "É um parâmetro que indica a capacidade de uma atividade de gerar incômodos relacionados à poluição ambiental e que estabelece a localização que tal atividade pode ser instalada. Os Graus de Incomodidade vão de 1 a 5, sendo:\n\nGrau 1 – Baixíssimo: A sua capacidade de gerar incômodos, poluição e nocividade a população, fauna e flora é consideravelmente baixíssima, podendo localizar-se na macrozona estritamente residencial urbana, ou de hospitais ou de escolas;\n\nGrau 2 – Baixo: A sua capacidade de gerar incômodos, poluição e nocividade a população, fauna e flora é consideravelmente baixa, podendo localizar-se na macrozona em área mista, predominantemente residencial;\n\nGrau 3 – Médio: A sua capacidade de gerar incômodos, poluição e nocividade a população, fauna e flora é consideravelmente média, devendo assim instalar-se nos principais corredores de tráfego da zona urbana, respeitando assim as legislações e normas municipais, estaduais e federais;\n\nGrau 4 – Alto: A sua capacidade de gerar incômodos, poluição e nocividade a população, fauna e flora é consideravelmente alta, devendo assim instalar-se nas Zonas de Expansão da Cidade Nova, Zona de Expansão da Nova Marabá e Zonas Especiais Industriais, respeitando assim as legislações e normas municipais, estaduais e federais;\n\nGrau 5 – Altíssimo: A sua capacidade de gerar incômodos, poluição e nocividade a população, fauna e flora é consideravelmente alta, devendo assim instalar-se nas Zonas Especiais Industriais e Zona Rural, respeitando assim as legislações e normas municipais, estaduais e federais.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      9: {
        "titulo":
            "10 - Classificação das atividades quanto aos Usos Geradores de Interferência no Tráfego:",
        "type": "selecionar",
        "options": [
          "Geradoras de carga e descarga",
          "Geradoras de embarque e desembarque",
          "Geradoras de tráfego de pedestres",
          "Geradoras de viagens",
          "Nenhuma das anteriores ",
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "texto_apoio":
            "Para qualquer dessas atividades, o empreendimento é considerado como Uso Gerador de Interferência no Tráfego.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      10: {
        "titulo":
            "11 - Sabendo que o empreendimento é considerado como Uso Gerador de Impacto à Vizinhança, em qual dos casos ele se encaixa?",
        "type": "selecionar_2",
        "options": [
          "Projetos de implantação, modificação, ampliação ou regularização de...",
          "Parcelamento do solo em glebas urbanas",
          "Empreendimentos de caráter urbano a serem estabelecidos na área rural ou em áreas de urbanização específica",
          "Demais casos previstos em lei específica",
        ],
        "options2": [
          "os empreendimentos residenciais com mais de 100 unidade habitacionais ou quando situadas em terrenos com área igual ou superior a 10.000 m²",
          "estações, terminais e edificações de suporte dos sistemas rodoviário urbano, intermunicipal e interestadual, ferroviário, metroviário, aquaviário e similares, com área construída superior a 750m²",
          "garagens de veículos de transporte de passageiros",
          "os estabelecimentos de ensino, pesquisa e extensão, com área construída igual ou superior a 2.000m², com no mínimo 600 alunos por turno ou período",
          "centros comerciais, shoppings centers, supermercados e hipermercados com área construída igual ou superior a 2.000m²",
          "estabelecimentos de saúde como hospitais, centros de saúde, clínicas e similares com área construída igual ou superior a 2.000m², com capacidade igual ou superior a 200 leitos simultaneamente",
          "hotéis, pensões, pousadas, com área superior a 2.000 m²",
          "cemitérios e crematórios",
          "ginásios, estádios, hipódromos, hípicas, centros e complexos esportivos",
          "autódromos, kartódromos e similares",
          "centrais de cargas, logística, abastecimento e transportadoras",
          "presídios, complexos prisionais, centro de reabilitação de menores e similares",
          "casas noturnas, casas de show e similares",
          "Parque agropecuário, parque de diversão, sambódromo e similares",
          "Zoológico, jardim botânico e similares",
          "estacionamentos em superfície estabelecidos em lotes com uso exclusivo para este fim, para qualquer tipo de veículo e administrados por empresa regulamentada",
          "portos, aeroportos, aeródromos, heliportos e similares",
          "postos de abastecimento de combustíveis",
          "depósitos de gás liquefeito de petróleo",
          "depósito de inflamáveis, tóxicos e equiparáveis",
          "estações de tratamento",
          "estação de rádio base",
          "condomínios",
          "atividades de alto ou altíssimo nível de incomodidade",
          "demais atividades ou empreendimentos não residenciais com área construída igual ou superior a 3.000m²"
        ],
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "callback2": (value) {
          widget.option2 = value;
        },
        "texto_apoio":
            "Os Usos Geradores de Impacto à Vizinhança são todos aqueles que possam vir a causar alteração significativa no ambiente natural ou construído, ou sobrecarga na capacidade de atendimento da infraestrutura básica, listados no Art. 146 da Lei Municipal Nº 17.846/2018 (Plano Diretor Participativo de Marabá).",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      11: {
        "titulo": "12 - Qual a área total do lote, em metros quadrados?",
        "type": "escrever_numero",
        "unidade": "m²",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a área total, em metros quadrados, constada no documento do terreno.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      12: {
        "titulo": "13 - Qual a menor cota altimétrica da área, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "Cotas altimétricas são medidas, em metros, da altura do terreno, geralmente aferidas por um levantamento planialtimétrico.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      13: {
        "titulo": "14 - Qual o Coeficiente de Aproveitamento da edificação?",
        "type": "escrever_numero",
        "unidade": "",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a relação entre o total das áreas construídas e a área do terreno em que se implantará a edificação (CA = AC/AT). Não são computadas no cálculo as áreas de: subsolos para estacionamento; pavimentos sob pilotis quando abertos e livres no mínimo em 70% de sua área; equipamentos de lazer no nível do terreno ou cobertura, exceto para empreendimentos de lazer; estacionamento de veículos, exceto para edifícios garagem ou estacionamento de uso comercial; casas de máquinas, caixas d’água, centrais de ar condicionado, antenas de sinalização; sacadas privativas, desde que não vinculadas às dependências de serviço e com área inferior a 5% do pavimento.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      14: {
        "titulo": "15 - Qual a Taxa de Ocupação da edificação, em porcentagem?",
        "type": "escrever_numero",
        "unidade": "%",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a relação entre a projeção horizontal da área construída e a área do terreno (TO = PAC x 100 / AT). Não são computadas no cálculo as áreas de: equipamentos de lazer no nível do terreno ou cobertura, exceto para empreendimentos de lazer; estacionamento de veículos, exceto para uso comercial; pergolados até 4 m de largura; marquises; beirais de até 1,2 m; sacadas e balcões de até 1,2 m em balanço e com área inferior a 5% da superfície do pavimento.",
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
            "Corresponde ao percentual mínimo da área do terreno que deve permanecer permeável.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      16: {
        "titulo": "17 - Qual o recuo frontal da edificação, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a distância, em metros, do limite frontal do terreno até a edificação.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      17: {
        "titulo": "18 - Qual o recuo de fundo da edificação, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a distância, em metros, do limite do fundo do terreno até a edificação.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      18: {
        "titulo":
            "19 - Qual o recuo da lateral direita da edificação, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a distância, em metros, do limite da lateral direita do terreno até a edificação.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      19: {
        "titulo":
            "20 - Qual o recuo da lateral esquerda da edificação, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a distância, em metros, do limite da lateral esquerda do terreno até a edificação.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      20: {
        "titulo":
            "21 - Qual o recuo da lateral de esquina da edificação, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a distância, em metros, do limite da lateral de esquina do terreno até a edificação.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
      21: {
        "titulo": "22 - Qual a altura da edificação, em metros?",
        "type": "escrever_numero",
        "unidade": "m",
        "callback": (value) {
          widget.respostas[widget.actual_page] = value;
        },
        "on_submitted": onSubmitted,
        "texto_apoio":
            "É a distância, em metros, do nível do terreno até a maior altura da edificação.",
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
            "É a distância, em metros, dos limites laterais da frente do terreno.",
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
            "É a distância, em metros, dos limites laterais da faixa transitável da via de acesso ao terreno.",
        "hasImagem": false,
        "imagens": [],
        "nome_imagem": []
      },
    };
  }
}
