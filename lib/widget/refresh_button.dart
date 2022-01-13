import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  final VoidCallback onTap;

  const RefreshButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      iconSize: 30,
      icon: Icon(
        Icons.refresh_rounded,
        color: Colors.blue,
      ),
    );
  }
}
