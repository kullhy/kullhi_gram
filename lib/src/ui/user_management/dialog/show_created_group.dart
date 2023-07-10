import 'package:flutter/material.dart';

import '../create_user/cancel_button.dart';
import '../create_user/confirm_button.dart';
import '../create_user/input_create_fieldname.dart';


class ShowDialogCreatedGroup{

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
static Future<void> showCreateGroupDialog(BuildContext context) async {
    final Size size = MediaQuery.of(context).size;

    await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController groupNameController = TextEditingController();
        return StatefulBuilder(
          builder: (context, setState) {
            return FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.8, // Adjust the width factor as needed
              child: AlertDialog(
                key: _formKey,
                content: Form(
                  child: Container(
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(200, 168, 201, 0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                     const   Text(
                          'New Group',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: InputGroupNameField(
                            text: 'Group name',
                            input: groupNameController,
                            hint: 'Input new group name',
                            validator: 'Please fill in the group name',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CancelButton(
                                size: size,
                                text: 'Cancel',
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              SizedBox(width: size.width * 0.03),
                              ConfirmButton(
                                size: size,
                                text: 'Confirm',
                                onTap: () {
                                  // Handle the confirm button action
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}