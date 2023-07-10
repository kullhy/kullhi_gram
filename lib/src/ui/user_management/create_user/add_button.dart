import 'package:flutter/material.dart';

class AddUserButton extends StatelessWidget {
  const AddUserButton({
    Key? key,
    required this.size,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.29),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size.height * 0.08,
          width: size.width * 0.2,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 55, 79, 113),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
