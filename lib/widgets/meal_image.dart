import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealImage extends StatelessWidget {
  const MealImage({
    super.key,
    required this.url,
    required this.height,
    this.cacheWidth = 900,
  });

  final String url;
  final double height;
  final int cacheWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        // Decode at a bounded size to save memory.
        image: ResizeImage(NetworkImage(url), width: cacheWidth),
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 250),
        imageErrorBuilder: (_, __, ___) => ColoredBox(
          color: scheme.surfaceContainerHighest,
          child: Icon(Icons.restaurant, size: 48, color: scheme.outline),
        ),
      ),
    );
  }
}
