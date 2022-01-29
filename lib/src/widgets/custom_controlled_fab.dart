import 'package:flutter/material.dart';

class CustomControlledFab extends StatefulWidget {
  final Duration duration;
  const CustomControlledFab({
    Key? key,
    required this.duration,
  }) : super(key: key);

  @override
  _CustomControlledFabState createState() => _CustomControlledFabState();
}

class _CustomControlledFabState extends State<CustomControlledFab>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Size?> sizeAnimation;
  late Animation<Alignment?> alignAnimation;
  late Animation<BorderRadius?> radiusAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    sizeAnimation = SizeTween(
      begin: const Size(50, 50),
      end: const Size(100, 50),
    ).animate(controller);

    alignAnimation = AlignmentTween(
      begin: Alignment.bottomRight,
      end: Alignment.topCenter,
    ).animate(controller);

    radiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(50),
      end: BorderRadius.circular(5),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return GestureDetector(
            onTap: _toggle,
            child: Align(
              alignment: alignAnimation.value!,
              child: Container(
                height: sizeAnimation.value?.height,
                width: sizeAnimation.value?.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: radiusAnimation.value,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
