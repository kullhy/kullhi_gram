import 'package:flutter/material.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String selectedOption = '';
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(200, 168, 201, 0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10)),
            ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [       
            DropdownButton<String>(
              
              hint: const Text('Choose status',style:TextStyle(fontSize: 12,fontWeight: FontWeight.w400)),
              underline: const SizedBox(),
              value: selectedOption.isNotEmpty ? selectedOption : null,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
