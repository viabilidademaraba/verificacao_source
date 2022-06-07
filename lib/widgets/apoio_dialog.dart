import 'package:flutter/material.dart';
import 'package:verificacao/utils/hexcolor.dart';
import 'package:verificacao/widgets/button2.dart';

class ApoioDialog extends StatelessWidget {
  List imagens;
  String texto;
  final double borderRadius = 10;
  final transformationController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();

  List nomeImagem;

  bool hasImagem;

  ApoioDialog(
      {Key? key,
      required this.texto,
      required this.imagens,
      required this.nomeImagem,
      required this.hasImagem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 803,
        constraints: const BoxConstraints(maxHeight: 600),
        decoration: BoxDecoration(
          color: HexColor("#252525"),
          border: Border.all(
            color: HexColor("#FBFEDC"),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: hasImagem ? com_imagem(context) : sem_imagem(context),
      ),
    );
  }

  Row botao_imagem(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imagens.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Button2(
            text: nomeImagem[index],
            size: 2,
            callback: () => openImage(imagens[index], context),
          ),
        ),
      ),
    );
  }

  openImage(image, context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
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
            child: Center(
              child: GestureDetector(
                onDoubleTap: _handleDoubleTap,
                onDoubleTapDown: _handleDoubleTapDown,
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(100),
                  minScale: 1,
                  maxScale: 6,
                  transformationController: transformationController,
                  child: Image.asset(image, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (transformationController.value != Matrix4.identity()) {
      transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 5, -position.dy * 5)
        ..scale(6.0);
    }
  }

  com_imagem(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        const Spacer(),
        Text(
          texto,
          style: TextStyle(color: HexColor("#ECECEC"), fontSize: 24),
          textAlign: TextAlign.justify,
        ),
        const Spacer(),
        botao_imagem(context),
        const Spacer(),
      ],
    );
  }

  sem_imagem(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              texto,
              style: TextStyle(color: HexColor("#ECECEC"), fontSize: 24),
              textAlign: TextAlign.justify,
            ),
          ),
        )
      ],
    );
  }
}
