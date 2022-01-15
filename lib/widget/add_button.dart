import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      iconSize: 30,
      icon: Icon(
        Icons.add,
        color: Colors.green,
      ),
    );
  }
}
