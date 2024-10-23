import 'package:flutter/material.dart';

class TabTagetWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final int? quarterTurns;
  final double width;
  final double height;
  final Color? color;
  final Function(Object?) onAccept;
  const TabTagetWidget({
    super.key,
    required this.child,
    required this.title,
    this.quarterTurns,
    required this.onAccept,
    required this.width,
    required this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAccept: (data) {
        onAccept(data);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: width,
          height: height,
          color: color ?? Colors.grey,
          padding: EdgeInsets.only(left: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              RotatedBox(
                quarterTurns: quarterTurns ?? 0,
                child: Text(
                  "${title}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
              child
            ],
          ),
        );
      },
    );
  }
}
