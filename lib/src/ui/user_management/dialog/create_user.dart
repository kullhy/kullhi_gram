import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/ui/user_management/create_user/input_field.dart';

import '../create_user/add_button.dart';
import '../create_user/dropdown_button.dart';

class CreatedUserDialog {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> showCreateUserDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController firstName = TextEditingController();
        final TextEditingController lastName = TextEditingController();
        final TextEditingController phoneNumber = TextEditingController();
        final TextEditingController email = TextEditingController();

        return LayoutBuilder(
          builder: (context, constraints) {
            final Size size = constraints.biggest;

            return AlertDialog(
              key: _formKey,
              content: SizedBox(
                width: size.width * 0.9,
                child: ListView(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.9,
                          width: size.width * 0.19,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 236, 245, 245),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * .045,
                                      left: size.width * .007,
                                    ),
                                    child: SizedBox(
                                      width: size.width * 0.15,
                                      height: size.height * 0.2,
                                      child: const CircleAvatar(
                                        backgroundImage: AssetImage(
                                          'assets/images/profile.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.2),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * .065),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Official status',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              const DropdownButtonExample(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              InputField(
                                text: 'First name',
                                input: firstName,
                                hint: "First name",
                                validator: 'Please input your first name',
                              ),
                              InputField(
                                text: 'Last name',
                                input: lastName,
                                hint: "Last name",
                                validator: 'Please input your last name',
                              ),
                              InputField(
                                text: 'Phone number',
                                input: phoneNumber,
                                hint: "Phone number",
                                validator: 'Please input your phone number',
                              ),
                              InputField(
                                text: 'Email',
                                input: email,
                                hint: "Email",
                                validator: 'Please input your email',
                              ),
                              SizedBox(height: size.height * .09),
                              AddUserButton(
                                size: size,
                                text: 'Add',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
