import 'package:flutter/material.dart';
import 'build_guilding.dart';
import 'package:tuto/models/guide.dart';
import 'package:tuto/widgets/guiding_controller.dart';
import 'package:tuto/widgets/guiding_widget.dart';

class HomePageWithGuiding extends StatefulWidget {
  const HomePageWithGuiding(
      {Key? key, this.duration = const Duration(milliseconds: 2500)})
      : super(key: key);

  final Duration duration;

  @override
  HomePageWithGuidingState createState() => HomePageWithGuidingState();
}

class HomePageWithGuidingState extends State<HomePageWithGuiding> {
  final _userGuidanceController = GuidingController();
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final media = MediaQuery.of(context);
    final List<GuideVisualAndSound> guidesExt = buildGuiding(media);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Flutter User Guidance Example'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.slideshow),
                onPressed: () => _userGuidanceController.show(),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text('$_counter', style: theme.textTheme.headline4),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _handleFABPressed,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
        GuidingWidget(
          controller: _userGuidanceController,
          guideExts: guidesExt,
        ),
      ],
    );
  }

  void _handleFABPressed() => setState(() => _counter++);
}
