import 'dart:math';

import 'package:flutter/material.dart';

class CustomControlledExpansionTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String description;

  const CustomControlledExpansionTile({
    required this.title,
    required this.description,
    this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomControlledExpansionTile> createState() =>
      _CustomControlledExpansionTileState();
}

class _CustomControlledExpansionTileState
    extends State<CustomControlledExpansionTile> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double?> angleAnimation;
  late Animation<Color?> colorAnimation;
  late Animation<double?> heightAnimation;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    angleAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(controller);

    heightAnimation = Tween<double>(
      begin: 0,
      end: 1.1,
    ).animate(controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    colorAnimation = ColorTween(
      begin: Theme.of(context).textTheme.headline6!.color!,
      end: Theme.of(context).primaryColor,
    ).animate(controller);
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  void _toggle() {
    if (controller.value == 0) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  bool hasSubtitle() => widget.subtitle != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Column(
            children: [
              GestureDetector(
                onTap: _toggle,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(color: colorAnimation.value),
                          ),
                          hasSubtitle()
                              ? Text(
                                  widget.subtitle!,
                                  style: TextStyle(color: colorAnimation.value),
                                )
                              : Container(),
                        ],
                      ),
                      Transform.rotate(
                        angle: angleAnimation.value!,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: colorAnimation.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRect(
                child: Align(
                  heightFactor: heightAnimation.value!,
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const FlutterLogo(),
                        Text(widget.description),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
