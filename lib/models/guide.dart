import 'package:flutter/material.dart';

class Guide {}

class GuideVisualAndSound extends GuideVisual {
  void Function() playSound;

  GuideVisualAndSound.rect(Rect rect, Widget guidingText,
      {required this.playSound})
      : super.rect(rect, guidingText);
  GuideVisualAndSound.circle(Rect rect, Widget guidingText,
      {required this.playSound})
      : super.circle(rect, guidingText);
  GuideVisualAndSound.custom(Rect rect, Widget guidingText,
      {required Decoration decoration, required this.playSound})
      : super.custom(rect, guidingText, decoration: decoration);
}

class GuideVisual extends Guide {
  final Rect rect;
  final Decoration decoration;
  final Widget guidingText;
  GuideVisual._(this.rect, this.decoration, this.guidingText);

  /// Create a custom [Guide2] instance.
  /// NOTICE: To take effect set any color e.g. [Colors.white].
  GuideVisual.custom(Rect rect, Widget widget, {required Decoration decoration})
      : this._(rect, decoration, widget);

  GuideVisual.rect(Rect rect, Widget widget)
      : this._(
            rect,
            const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
            ),
            widget);

  GuideVisual.circle(Rect rect, Widget widget)
      : this._(
            rect,
            const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            widget);
}
