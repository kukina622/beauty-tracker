import 'package:flutter/material.dart';

final appIcons = [
  Icons.face,
  Icons.face_retouching_natural,
  Icons.brush,
  Icons.spa,
  Icons.air,
  Icons.auto_awesome,
  Icons.water_drop,
  Icons.colorize,
  Icons.opacity,
  Icons.local_pharmacy,
  Icons.sanitizer,
  Icons.visibility,
  Icons.wb_sunny,
  Icons.ac_unit,
  Icons.favorite,
  Icons.star,
  Icons.format_paint,
  Icons.palette,
  Icons.science,
  Icons.category,
  Icons.build,
  Icons.style,
  Icons.diamond,
  Icons.bubble_chart,
  Icons.color_lens,
  Icons.invert_colors,
  Icons.filter_vintage,
  Icons.emoji_emotions,
  Icons.self_improvement,
  Icons.healing,
  Icons.eco,
  Icons.waves,
  Icons.blur_on,
  Icons.flare,
  Icons.grain,
  Icons.brightness_7,
  Icons.tonality,
  Icons.lens,
  Icons.panorama_fish_eye,
  Icons.circle,
];

final appIconMapping = Map<int, IconData>.fromIterables(
  List.generate(appIcons.length, (index) => appIcons[index].codePoint),
  appIcons,
);

IconData getAppIcon(int? iconCode) {
  if (iconCode == null || iconCode < 0) {
    return Icons.spa;
  }
  return appIconMapping[iconCode] ?? Icons.spa;
}
