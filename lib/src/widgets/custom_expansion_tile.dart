import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String description;

  const CustomExpansionTile({
    required this.title,
    required this.description,
    this.subtitle,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  final _duration = const Duration(seconds: 1);
  bool isExpanded = false;

  void _toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  bool hasSubtitle() => widget.subtitle != null;

  Color get expandedColor => isExpanded
      ? Theme.of(context).primaryColor
      : Theme.of(context).textTheme.headline6!.color!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
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
                        style: TextStyle(color: expandedColor),
                      ),
                      hasSubtitle()
                          ? Text(
                              widget.subtitle!,
                              style: TextStyle(color: expandedColor),
                            )
                          : Container(),
                    ],
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: _duration,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: expandedColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRect(
            child: AnimatedAlign(
              heightFactor: isExpanded ? 1.1 : 0,
              duration: _duration,
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
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(widget.description),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
