import 'package:flutter/material.dart';

class CustomFab extends StatefulWidget {
  final Duration duration;
  const CustomFab({
    Key? key,
    required this.duration,
  }) : super(key: key);

  @override
  State<CustomFab> createState() => _CustomFabState();
}

class _CustomFabState extends State<CustomFab> {
  bool isFAB = true;

  void toggle() {
    setState(() {
      isFAB = !isFAB;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: toggle,
        child: AnimatedAlign(
          duration: widget.duration,
          alignment: isFAB ? Alignment.bottomRight : Alignment.topCenter,
          child: AnimatedContainer(
            height: 50,
            width: isFAB ? 50 : 100,
            duration: widget.duration,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(isFAB ? 50 : 5),
            ),
          ),
        ),
      ),
    );
  }
}
