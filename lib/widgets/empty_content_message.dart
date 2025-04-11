import 'package:flutter/material.dart';

class EmptyContentMessage extends StatelessWidget {
  final String message;

  const EmptyContentMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
