import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton(
      {super.key, required this.size, required this.text, required this.onTap});
  final Size size;
  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap: onTap,
        child: Container(
            height: size.height * 0.07,
            width: size.width * 0.12,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 188, 188, 189),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 124, 122, 122),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )),
      
    );
  }
}
