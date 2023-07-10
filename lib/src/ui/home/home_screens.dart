import 'dart:convert';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/data/local/app_data.dart';
import 'package:min_soft_ware/src/gen/assets.gen.dart';
import 'package:min_soft_ware/src/network/api_path.dart';
import 'package:min_soft_ware/src/ui/message_screens/messages_screens.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/my_profile/user.dart';
import '../../features/personal/view/personal_screen.dart';
import '../user_management/management.dart';
import 'components/side_menu_item.dart';

String docummentPath = "";

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  User user = User();
  String optionWidget = "";
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  Future<User?> getUserData(String token) async {
    var headers = {'Authorization': token};
    var request = http.Request('GET', Uri.parse(ApiPath.getMe));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonData = await response.stream.bytesToString();
      Logger.d(jsonData);
      final dynamicData = jsonDecode(jsonData);
      final status = dynamicData['status'];

      if (status['code'] == 200) {
        final userJson = dynamicData['user'];
        setState(() {
          user = User.fromJson(userJson);
          AppProvider.instance.user = user;
        });
        Logger.d(jsonEncode(user));
        return user;
      } else {
        final message = status['message'];
        throw Exception('API Error: $message');
      }
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  int chatId = 0;
  String userName = "";

  void setChatId(int id, String name) {
    Logger.d("set chat id = $id");
    setState(() {
      chatId = id;
      userName = name;
    });
  }

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    getUserData(widget.token);
    super.initState();
  }

  Future<void> getDocumentsDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    docummentPath = directory.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primary,
        elevation: 0,
        leading: Container(padding: EdgeInsets.only(left: 10.w), child: Assets.image.logo.image(height: 20, width: 20)),
        title: Text(
          "${user.name} - ${user.phone} - ${user.email} ",
          style: AppFont.t.s(20).w600,
        ),
      ),
      body: Row(
        children: [
          SideMenu(
            controller: sideMenu,
            style: SideMenuStyle(
              backgroundColor: Palette.primary,
              displayMode: SideMenuDisplayMode.compact,
              hoverColor: Colors.blue[100],
              selectedHoverColor: Color.alphaBlend(
                  Color.fromRGBO(
                      Theme.of(context).colorScheme.surfaceTint.red, Theme.of(context).colorScheme.surfaceTint.green, Theme.of(context).colorScheme.surfaceTint.blue, 0.08),
                  Colors.blue[100]!),
              selectedColor: Colors.lightBlue,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
            ),
            footer: Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                'Min software',
                style: AppFont.t.s(15),
              ),
            ),
            items: [
              menuIteam(priority: 0, title: "Tin nhắn", sideMenu: sideMenu, icon: Icons.messenger),
              menuIteam(priority: 1, title: "Chăm sóc khách hàng", sideMenu: sideMenu, icon: Icons.headset_mic_outlined),
              menuIteam(priority: 2, title: "Liên hệ", sideMenu: sideMenu, icon: Icons.folder),
              menuIteam(priority: 3, title: "Quản lý người dùng", sideMenu: sideMenu, icon: Icons.manage_accounts_outlined),
              menuIteam(priority: 4, title: "Quản lý hợp đồng", sideMenu: sideMenu, icon: Icons.note_alt_outlined),
              menuIteam(priority: 5, title: "Tài khoản", sideMenu: sideMenu, icon: Icons.person_outline),
              menuIteam(
                priority: 6,
                title: "Đăng xuất",
                sideMenu: sideMenu,
                icon: Icons.logout_outlined,
                onError: () {
                  setState(() {});
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                const MessagesScreens(),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Users',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Files',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                const Management(),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Download',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
                const PersonalScreen(),
                Container(
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Only Icon',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
