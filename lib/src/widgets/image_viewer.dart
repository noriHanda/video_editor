import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_editor/src/controller.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.controller,
    required this.bytes,
    this.child,
    this.fadeIn = true,
  });

  final VideoEditorController controller;
  final Uint8List bytes;
  final Widget? child;
  final bool fadeIn;

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.video.rect.value?.size.aspectRatio;
    if (aspectRatio == null) return const SizedBox();
    assert(aspectRatio > 0, 'Aspect ratio must be greater than 0');

    return Center(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: fadeIn
                ? FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 400),
                    image: MemoryImage(bytes),
                    placeholder: MemoryImage(kTransparentImage),
                  )
                : Image.memory(
                    bytes,
                    color: const Color.fromRGBO(255, 255, 255, 0.2),
                    colorBlendMode: BlendMode.modulate,
                  ),
          ),
          if (child != null)
            AspectRatio(
              aspectRatio: aspectRatio,
              child: child,
            ),
        ],
      ),
    );
  }
}
