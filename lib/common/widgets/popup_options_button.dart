import 'package:flutter/material.dart';
import 'package:user_app/common/constants/enums.dart';

class PopupOptionsButton extends StatelessWidget {
  final Map<DialogAction, VoidCallback> options;

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
        final action = DialogAction.values.firstWhere((e) => e.name == value);
        options[action]?.call();
      },
      itemBuilder: (BuildContext context) {
        return options.entries.map((entry) {
          return PopupMenuItem<String>(
            value: entry.key.name,
            child: Text(entry.key.name),
          );
        }).toList();
      },
    );
  }
}
