import 'package:flutter/material.dart';

class ItemDrag extends StatelessWidget {
  final String text;
  const ItemDrag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.black)),
      child: Text(text),
    );
  }
}

class DraggableWidget extends StatelessWidget {
  final String data;
  const DraggableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: data,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ItemDrag(text: data),
      ),
      feedback: Material(child: ItemDrag(text: data)),
    );
  }
}
