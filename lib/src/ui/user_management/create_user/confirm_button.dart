import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  const ConfirmButton(
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
              color: const Color.fromARGB(255, 55, 79, 113),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )),
      
    );
  }
}

