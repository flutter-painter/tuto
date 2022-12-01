import 'package:flutter/material.dart';
import 'package:tuto/models/guide.dart';
import 'package:tuto/widgets/guiding_controller.dart';

class GuidingWidget extends StatefulWidget {
  final List<GuideVisualAndSound> guideExts;
  final GuidingController controller;
  final Duration duration;
  const GuidingWidget({
    Key? key,
    required this.guideExts,
    required this.controller,
    this.duration = const Duration(milliseconds: 250),
  })  : assert(guideExts.length > 0,
            'Property "guides" should have at least one element'),
        super(key: key);

  @override
  GuidingWidgetState createState() => GuidingWidgetState();
}

class GuidingWidgetState extends State<GuidingWidget> {
  late GuidingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GuidingController();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<GuidingValue>(
      valueListenable: widget.controller,
      builder: (_, value, child) {
        return AnimatedSwitcher(
          duration: widget.duration,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: value.visible
              ? SizedBox(key: const ValueKey(0), child: child)
              : const SizedBox(key: ValueKey(1)),
        );
      },
      child: GestureDetector(
        onTap: _handlePressed,
        child: Stack(
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.black87,
                  BlendMode.srcOut,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          backgroundBlendMode: BlendMode.dstOut,
                        ),
                      ),
                    ),
                    ValueListenableBuilder<GuidingValue>(
                      valueListenable: widget.controller,
                      builder: (context, value, child) {
                        final userGuide = widget.guideExts[value.step];

                        return AnimatedPositioned.fromRect(
                          duration: widget.duration,
                          rect: userGuide.rect,
                          child: AnimatedContainer(
                            duration: widget.duration,
                            decoration: userGuide.decoration,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: ValueListenableBuilder<GuidingValue>(
                valueListenable: _controller,
                builder: (context, value, child) {
                  final userGuide = widget.guideExts[value.step];
                  return AnimatedSwitcher(
                    duration: widget.duration,
                    child: SizedBox(
                      key: ValueKey<int>(value.step),
                      child: userGuide.guidingText,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePressed() {
    if (widget.controller.value.step + 1 < widget.guideExts.length) {
      widget.controller.next();
    } else {
      widget.controller.hide();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
