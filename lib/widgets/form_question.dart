import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'package:verificacao/widgets/apoio_dialog.dart';
import 'package:verificacao/widgets/form_button.dart';

class FormQuestion extends StatefulWidget {
  var pergunta;
  dynamic valores = -1;
  dynamic itemSelecionado;
  dynamic itemSelecionado2;
  bool bloquear = true;

  var question;

  FormQuestion({Key? key, required this.pergunta, this.question = false})
      : super(key: key);

  @override
  State<FormQuestion> createState() => _FormQuestionState();
}

class _FormQuestionState extends State<FormQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: HexColor("#383838"),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 3,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.question ? question(widget.pergunta) : const SizedBox.shrink(),
          const Spacer(flex: 1),
          Text(
            widget.pergunta["titulo"],
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const Spacer(flex: 1),
          getWidget(widget.pergunta),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Align question(pergunta) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ApoioDialog(
              texto: pergunta["texto_apoio"],
              imagens: pergunta["imagens"],
              nomeImagem: pergunta["nome_imagem"],
              hasImagem: pergunta["hasImagem"],
            ),
          );
        },
        child: Icon(
          Icons.question_mark_rounded,
          color: HexColor("#383838"),
        ),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.3),
          ),
          backgroundColor: MaterialStateProperty.all(HexColor("#F8E436")),
          shape: MaterialStateProperty.all(const CircleBorder()),
        ),
      ),
    );
  }

  getWidget(pergunta) {
    switch (pergunta["type"]) {
      case "button":
        return button(pergunta);
      case "selecionar":
        return selecionar(pergunta);
      case "selecionar_2":
        return selecionar2(pergunta);
      case "escrever_numero":
        return escreverNumero(pergunta);
      case "escrever":
        return escrever(pergunta);
    }
    return const Text("Error");
  }

  button(pergunta) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pergunta["options"].length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FormButton(
              text: pergunta["options"][index],
              preenchido: pergunta["options"][index].toLowerCase() == "sim"
                  ? true
                  : false,
              callback: pergunta["callback"][index],
            ),
          );
        },
      ),
    );
  }

  selecionar(pergunta) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: HexColor("#5F5B5B"),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: HexColor("#5F5B5B")),
        child: DropdownButton(
          style: TextStyle(color: HexColor("#B8B8B8")),
          isExpanded: false,
          hint: Text(
            "Selecione uma opção...",
            style: TextStyle(color: HexColor("#B8B8B8")),
          ),
          items: List.generate(
            pergunta["options"].length,
            (index) => DropdownMenuItem(
              value: pergunta["options"][index],
              child: Text(pergunta["options"][index]),
            ),
          ),
          value: widget.itemSelecionado,
          onChanged: (value) => setState(
            () {
              pergunta["callback"](value);
              widget.itemSelecionado = value;
            },
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: HexColor("#9D9898"),
          ),
          iconSize: 42,
          underline: const SizedBox(),
        ),
      ),
    );
  }

  escreverNumero(pergunta) {
    return Container(
      width: 200,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: HexColor("#5F5B5B"),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              onSubmitted: pergunta["on_submitted"],
              onChanged: pergunta["callback"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              controller: MoneyMaskedTextController(
                decimalSeparator: '.',
                thousandSeparator: '',
              ),
              decoration: InputDecoration(
                counterStyle: TextStyle(color: HexColor("#F3F3F3")),
                fillColor: HexColor("#5F5B5B"),
                filled: false,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#383838")),
                ),
                suffixText: pergunta["unidade"],
                suffixStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  escrever(pergunta) {
    return Container(
      width: 500,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: HexColor("#5F5B5B"),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              onSubmitted: pergunta["on_submitted"],
              onChanged: pergunta["callback"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              maxLength: 64,
              decoration: InputDecoration(
                counterStyle: TextStyle(color: HexColor("#F3F3F3")),
                fillColor: HexColor("#5F5B5B"),
                filled: false,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#383838")),
                ),
                counterText: "",
              ),
            ),
          ),
        ],
      ),
    );
  }

  selecionar2(pergunta) {
    // ignore: prefer_function_declarations_over_variables
    var callback = (value) => setState(
          () {
            pergunta["callback2"](value);
            widget.itemSelecionado2 = value;
          },
        );

    return Expanded(
      flex: 8,
      child: Column(
        children: [
          Container(
            height: 35,
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: HexColor("#5F5B5B"),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Theme(
              data:
                  Theme.of(context).copyWith(canvasColor: HexColor("#5F5B5B")),
              child: DropdownButton(
                style: TextStyle(color: HexColor("#B8B8B8")),
                isExpanded: true,
                hint: Text(
                  "Selecione uma opção...",
                  style: TextStyle(color: HexColor("#B8B8B8")),
                ),
                items: List.generate(
                  pergunta["options"].length,
                  (index) => DropdownMenuItem(
                    value: pergunta["options"][index],
                    child: Text(pergunta["options"][index]),
                  ),
                ),
                value: widget.itemSelecionado,
                onChanged: (value) => setState(
                  () {
                    widget.bloquear = true;
                    if (value == pergunta["options"][0]) {
                      pergunta["callback2"]("");
                      widget.bloquear = false;
                    }
                    pergunta["callback"](value);
                    widget.itemSelecionado = value;
                  },
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: HexColor("#9D9898"),
                ),
                iconSize: 42,
                underline: const SizedBox(),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 35,
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: HexColor("#5F5B5B"),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Theme(
              data:
                  Theme.of(context).copyWith(canvasColor: HexColor("#5F5B5B")),
              child: DropdownButton(
                style: TextStyle(color: HexColor("#B8B8B8")),
                isExpanded: true,
                hint: Text(
                  "Selecione uma opção...",
                  style: TextStyle(color: HexColor("#B8B8B8")),
                ),
                value: widget.itemSelecionado2,
                onChanged: widget.bloquear ? null : callback,
                items: List.generate(
                  pergunta["options2"].length,
                  (index) => DropdownMenuItem(
                    value: pergunta["options2"][index],
                    child: Text(pergunta["options2"][index]),
                  ),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: HexColor("#9D9898"),
                ),
                iconSize: 42,
                underline: const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
