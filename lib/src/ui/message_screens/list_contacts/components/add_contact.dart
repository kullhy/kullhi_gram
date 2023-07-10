import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../list_contacts_view_model.dart';

Future addContactDiaLog(BuildContext context) {
  final viewModel = Provider.of<ListContactsViewModel>(context, listen: false);
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  return showDialog(
    context: viewModel.curContext,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ADD CONTACT'),
        content: SizedBox(
          height: 600.h,
          width: 400.w,
          child: Column(
            children: [
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              final phoneNumber = phoneNumberController.text.trim();
              final firstName = nameController.text.trim();
              viewModel.addContact(phoneNumber, firstName);
              Navigator.of(context).pop();
            },
            child: const Text('Add Contact'),
          ),
        ],
      );
    },
  );
}
