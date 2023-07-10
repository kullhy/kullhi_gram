import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/data/local/app_data.dart';
import 'package:min_soft_ware/src/share_components/text_feild/my_text_field.dart';

import '../../../share_components/button/buttom_primary.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<PersonalViewModel>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width / 3 - 100,
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
                        top: height * .045,
                        left: width * .007,
                      ),
                      child: SizedBox(
                        width: width * 0.15,
                        height: height * 0.2,
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/image/profile.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.2),
                rowConten(
                  titel: "Họ Tên:",
                  value: AppProvider.instance.user?.name ?? "",
                ),
                rowConten(
                  titel: "Email:",
                  value: AppProvider.instance.user?.email ?? "",
                ),
                rowConten(
                  titel: "Phone:",
                  value: AppProvider.instance.user?.phone ?? "",
                ),
                rowConten(
                  titel: "Permission:",
                  value: AppProvider.instance.user?.permission ?? "",
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            width: width * 2 / 3,
            child: Row(
              children: [
                SizedBox(
                  width: width / 3 - 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyTextField(
                        title: 'Họ Tên',
                        titleStyle: AppFont.t.s(16).w600,
                        // controller: firstName,
                        hintText: "Email",
                        // validator: 'Please input your first name',
                      ),
                      MyTextField(
                        title: 'Email',
                        titleStyle: AppFont.t.s(16).w600,
                        // controller: firstName,
                        hintText: "First name",
                        // validator: 'Please input your first name',
                      ),
                      MyTextField(
                        titleStyle: AppFont.t.s(16).w600,
                        title: 'Số điện thoại',
                        // controller: firstName,
                        hintText: "First name",
                        // validator: 'Please input your first name',
                      ),
                      if (AppProvider.instance.user?.permission == "ADMIN")
                        MyTextField(
                          titleStyle: AppFont.t.s(16).w600,
                          title: 'permission',
                          // controller: firstName,
                          hintText: "First name",
                          // validator: 'Please input your first name',
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonPrimary(
                            width: 200,
                            color: Palette.blue,
                            action: () {},
                            text: "Cập Nhập thông tin",
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowConten({required String titel, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titel,
            style: AppFont.t.s(16).w600,
          ),
          Text(
            value,
            style: AppFont.t.s(16).w600,
          ),
        ],
      ),
    );
  }
}
