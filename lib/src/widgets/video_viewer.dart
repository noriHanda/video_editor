import 'package:flutter/material.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:video_editor/src/controller.dart';

class VideoViewer extends StatelessWidget {
  const VideoViewer({super.key, required this.controller, this.child});

  final VideoEditorController controller;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final aspectRatio = controller.video.rect.value?.size.aspectRatio;
    if (aspectRatio == null) return const SizedBox();
    assert(aspectRatio > 0, 'Aspect ratio must be greater than 0');

    return GestureDetector(
      onTap: () {
        if (controller.isPlaying) {
          controller.video.player.pause();
        } else {
          controller.video.player.play();
        }
      },
      child: Center(
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: aspectRatio,
              child: Video(controller: controller.video),
            ),
            if (child != null)
              AspectRatio(
                aspectRatio: aspectRatio,
                child: child,
              ),
          ],
        ),
      ),
    );
  }
}
