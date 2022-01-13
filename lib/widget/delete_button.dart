import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onTap;
  const DeleteButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        onPressed: onTap,
        iconSize: 30,
        icon: Icon(
          Icons.delete_rounded,
          color: Colors.red,
        ),
      ),
    );
  }
}
