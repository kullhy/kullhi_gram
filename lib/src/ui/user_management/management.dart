import 'package:flutter/material.dart';
import 'components/permissions_management.dart';
import 'components/user_management.dart';


class Management extends StatefulWidget {
  const Management({Key? key}) : super(key: key);

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  String optionWidget = "user";
  int id = 0;
  String permissionName = "";
  @override
  Widget build(BuildContext context) {
    if (optionWidget == "user") {
      return UserManagementScreens(
        option: (String o, int index, String name) {
          setState(() {
            optionWidget = o;
            id = index;
            permissionName = name;
          });
        },
      );
    } else {
      return (PermissionsManagement(
        index: id,
        permissionName: permissionName,
      ));
    }
  }
}
