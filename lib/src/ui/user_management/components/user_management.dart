import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/gen/assets.gen.dart';

import '../../../utils/helpers/logger.dart';
import '../dialog/show_created_group.dart';

class UserManagementScreens extends StatefulWidget {
  const UserManagementScreens({Key? key, required this.option}) : super(key: key);

  final Function(String, int, String) option;

  @override
  State<UserManagementScreens> createState() => _UserManagementScreensState();
}

class _UserManagementScreensState extends State<UserManagementScreens> {
  Map<String, String> userImage = {"DEV": "dev", "ADMIN": "admin", "SALE_ADMIN": "sale_admin", "SUPPORTER": "supporter", "OTHER": "other"};

  List listPermissions = [];

  Future<void> getPermissions() async {
    var response = await http.get(
      Uri.parse('http://103.170.122.165:6886/getPermissions'),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var permissions = responseData['permissions'];
      if (permissions is List) {
        setState(() {
          listPermissions = permissions;
        });
        Logger.d("", listPermissions);
      } else {
        listPermissions = ["", "", ""];
      }
    } else {
      Logger.d("Error:", response.statusCode);
      listPermissions = ["", "", ""];
    }
  }

  @override
  void initState() {
    getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: EdgeInsets.all(50.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Quản lý người dùng", overflow: TextOverflow.ellipsis, style: AppFont.t.s(30).grey.w600),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: InkWell(
                        onTap: () async {
                          await ShowDialogCreatedGroup.showCreateGroupDialog(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Palette.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.add,
                                color: Palette.white,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text("Tạo nhóm mới", overflow: TextOverflow.ellipsis, style: AppFont.t.s(20).w600.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 40.w,
                  runSpacing: 40.h,
                  children: List.generate(listPermissions.length, (index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 40) / 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          widget.option(
                            "permission",
                            index,
                            userImage[listPermissions[index]]!,
                          );
                        },
                        child: Row(
                          children: [
                            index < 5
                                ? Image.asset(
                                    "assets/image/${userImage[listPermissions[index]]}.png",
                                  )
                                : Assets.image.other.image(),
                            Expanded(
                              child: ListTile(
                                title: Text("${listPermissions[index]}", overflow: TextOverflow.ellipsis, style: AppFont.t.s(22).w600),
                                subtitle: Text(
                                  "Số lượng thành viên",
                                  style: AppFont.t.s(18).w500,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Icon(Icons.more_vert_outlined),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}
