import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String text;
  final TextEditingController input;
  final String hint;
  final String validator;

  const InputField({
    Key? key,
    required this.text,
    required this.input,
    required this.hint,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.045,
        left: size.width * 0.05,
        right: size.width * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color.fromARGB(255, 193, 19, 19),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.08,
            width: size.width * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: input,
              validator: (value) {
                return value!.isNotEmpty ? null : validator;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
