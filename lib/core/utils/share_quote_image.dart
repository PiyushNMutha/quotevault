import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../home/models/quote_model.dart';

Future<void> shareQuoteAsImage(BuildContext context, Quote quote) async {
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  const size = Size(1080, 1080);

  final paint = Paint()..color = const Color(0xFF0F2A5F);
  canvas.drawRect(Offset.zero & size, paint);

  final textPainter = TextPainter(
    text: TextSpan(
      text: '"${quote.text}"\n\n— ${quote.author}',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 42,
        fontStyle: FontStyle.italic,
      ),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );

  textPainter.layout(maxWidth: size.width - 100);
  textPainter.paint(
    canvas,
    Offset(50, size.height / 2 - textPainter.height / 2),
  );

  final image = await recorder.endRecording().toImage(1080, 1080);
  final bytes = await image.toByteData(format: ImageByteFormat.png);

  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/quote.png');
  await file.writeAsBytes(bytes!.buffer.asUint8List());

  await Share.shareXFiles([XFile(file.path)]);
}
