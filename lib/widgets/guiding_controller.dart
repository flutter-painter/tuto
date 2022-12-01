import 'package:flutter/material.dart';

class GuidingValue {
  const GuidingValue._([this.visible = false, this.step = 0]);
  const GuidingValue.initial() : this._();

  const GuidingValue.custom({required bool visible, required int step})
      : this._(visible, step);

  final bool visible;
  final int step;
}

class GuidingController extends ValueNotifier<GuidingValue> {
  GuidingController() : super(const GuidingValue.initial());

  void show({int from = 0}) {
    value = GuidingValue.custom(
      visible: true,
      step: from,
    );
  }

  void next() {
    value = GuidingValue.custom(
      visible: value.visible,
      step: value.step + 1,
    );
  }

  void hide() {
    value = GuidingValue.custom(
      visible: false,
      step: value.step,
    );
  }
}
