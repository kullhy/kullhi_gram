import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:min_soft_ware/src/utils/helpers/logger.dart';

import '../../../data/models/my_profile/user.dart';
import '../../check_login/check_login_screens.dart';
import '../dialog/create_user.dart';
import '../dialog/update_infor.dart';

// ignore: must_be_immutable
class PermissionsManagement extends StatefulWidget {
  const PermissionsManagement({Key? key, required this.index, required this.permissionName}) : super(key: key);
  final int index;
  final String permissionName;

  @override
  State<PermissionsManagement> createState() => _PermissionsManagementState();
}

class _PermissionsManagementState extends State<PermissionsManagement> {
  List<User> listUser = [];

  Future<void> getUser() async {
    var headers = {'Authorization': token};
    var request = http.Request('GET', Uri.parse('http://103.170.122.165:6886/getUsers?permission=${widget.index}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseData);
      var usersJson = jsonData['users'];

      if (usersJson is List) {
        setState(() {
          listUser = usersJson.map((userJson) => User.fromJson(userJson)).toList();
        });
      }
    } else {
      Logger.d("", response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(
                        "Quản lý ${widget.permissionName}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xFF615E5E),
                          fontSize: size.height * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          await CreatedUserDialog().showCreateUserDialog(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(size.height * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: size.height * 0.01,
                              ),
                              Text(
                                "Thêm thành viên",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: size.height * 0.05,
                  runSpacing: size.height * 0.05,
                  children: List.generate(
                    5,
                    (index) => Container(
                      padding: EdgeInsets.all(size.height * 0.02),
                      width: size.width * 0.23,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: index < 5
                                    ? const CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/images/avt.jpeg",
                                        ),
                                      )
                                    : Image.asset("assets/images/other.png"),
                              ),
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                  title: Container(
                                    margin: EdgeInsets.only(
                                      bottom: size.height * 0.01,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(
                                        'Kim Văn Hùng', //listUser[index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: size.height * 0.025,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    widget.permissionName.toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Icon(Icons.more_vert_outlined),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.04),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.01),
                                Padding(
                                  padding: EdgeInsets.only(right: size.width * 0.07),
                                  child: Text(
                                    "Sđt: 0123456789", // ${listUser[index].phone!}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                Text(
                                  "Email: kimhung123@gmail.com", //${listUser[index].email!}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await UpdateUserInfor().updateUserInfor(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: size.height * 0.04),
                              padding: EdgeInsets.all(size.height * 0.02),
                              height: size.height * 0.07,
                              width: size.width * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                    size: size.height * 0.02,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Cập nhật thông tin",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.height * 0.02,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
