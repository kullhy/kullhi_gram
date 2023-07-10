import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String? text;
  const Empty({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text ?? 'Không có dữ liệu'),
    );
  }
}
