import 'package:flutter/material.dart';

class PopupOptionsButton extends StatelessWidget {
  final Map<String, VoidCallback> options;

  const PopupOptionsButton({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: Icon(Icons.more_vert, color: Colors.black),
      onSelected: (value) {
        options[value]?.call();
      },
      itemBuilder: (BuildContext context) {
        return options.entries.map((entry) {
          return PopupMenuItem<String>(
            value: entry.key,
            child: Text(entry.key),
          );
        }).toList();
      },
    );
  }
}
