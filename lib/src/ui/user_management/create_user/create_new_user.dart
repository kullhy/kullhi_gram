// import 'package:flutter/material.dart';
// import 'package:min_software_dashboard/Screens/UserManagement/add_button.dart';
// import 'package:min_software_dashboard/Screens/UserManagement/dropdown_button.dart';
// import 'package:min_software_dashboard/Screens/UserManagement/input_field.dart';

// class CreateNewMemberInGroup extends StatefulWidget {
//   const CreateNewMemberInGroup({Key? key}) : super(key: key);

//   @override
//   State<CreateNewMemberInGroup> createState() => _CreateNewMemberInGroupState();
// }

// class _CreateNewMemberInGroupState extends State<CreateNewMemberInGroup> {
//   final TextEditingController firstName = TextEditingController();
//   final TextEditingController lastName = TextEditingController();
//   final TextEditingController phoneNumber = TextEditingController();
//   final TextEditingController email = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.sizeOf(context);
//     return Scaffold(
//         body: Center(
//       child: Container(
//         height: size.height * 0.9,
//         width: size.width * 0.64,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: const [
//               BoxShadow(
//                   color: Color.fromRGBO(200, 168, 201, 0.3),
//                   blurRadius: 20,
//                   offset: Offset(0, 10)),
//             ],
//             borderRadius: BorderRadius.circular(15)),
//         child: Row(
//           children: [
//             Container(
//               height: size.height * 0.9,
//               width: size.width * 0.19,
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 236, 245, 245),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: size.height * .045, left: size.width * .007),
//                         child: SizedBox(
//                           width: size.width * 0.15,
//                           height: size.height * 0.2,
//                           child: const CircleAvatar(
//                             backgroundImage:
//                                 AssetImage('assets/images/profile.png'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: size.height * 0.2),
//                   Padding(
//                     padding: EdgeInsets.only(left: size.width * .065),
//                     child: const Row(
//                       children: [
//                         Text(
//                           'Officiall status',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                          Text(
//                           '*',
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 193, 19, 19),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: size.height * 0.03),
//                   DropdownButtonExample()
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 InputField(
//                   text: 'First name',
//                   input: firstName,
//                   hint: "First name",
//                 ),
//                 InputField(
//                   text: 'Last name',
//                   input: lastName,
//                   hint: "Last name",
//                 ),
//                 InputField(
//                   text: 'Phone number',
//                   input: phoneNumber,
//                   hint: "Phone number",
//                 ),
//                 InputField(
//                   text: 'Email',
//                   input: email,
//                   hint: "Email",
//                 ),
//                 SizedBox(height: size.height * .09),
//                 SignInButton(
//                   size: size,
//                   text: 'Add',
//                   onTap: () {
//                     _handleLogin();
//                   },
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ));
//   }

//   void _handleLogin() async {
//     if (firstName.text.isEmpty &&
//         lastName.text.isEmpty &&
//         phoneNumber.text.isEmpty &&
//         email.text.isEmpty) {
//       ScaffoldMessenger(
//           child: Text(
//         'Please fill the field',
//         style: TextStyle(color: Colors.red[600]),
//       ));
//     } else if (firstName.text.isEmpty) {
//       ScaffoldMessenger(
//           child: Text(
//         'Please input your firstname',
//         style: TextStyle(color: Colors.red[600]),
//       ));
//     } else if (lastName.text.isEmpty) {
//       ScaffoldMessenger(
//           child: Text(
//         'Please input your lastname',
//         style: TextStyle(color: Colors.red[600]),
//       ));
//     } else if (email.text.isEmpty) {
//       ScaffoldMessenger(
//           child: Text(
//         'Please input your email',
//         style: TextStyle(color: Colors.red[600]),
//       ));
//     }else if (phoneNumber.text.isEmpty) {
//       ScaffoldMessenger(
//           child: Text(
//         'Please input your email',
//         style: TextStyle(color: Colors.red[600]),
//       ));
//     }
//   }
// }
