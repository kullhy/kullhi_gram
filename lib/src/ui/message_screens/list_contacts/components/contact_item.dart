import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:tdlib/td_api.dart' hide Text;

class ContactItems extends StatefulWidget {
  const ContactItems(
      {Key? key,
      required this.user,
      required this.lastMessage,
      required this.isSelected})
      : super(key: key);
  final User user;
  final List<String> lastMessage;
  final bool isSelected;

  @override
  State<ContactItems> createState() => _ContactItemsState();
}

class _ContactItemsState extends State<ContactItems> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    List<String> lastMessage = widget.lastMessage;
    return Container(
      height: 90.h,
      margin: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isSelected ? Palette.grayD9 : Palette.white),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/avt.jpeg",
                // fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.fromLTRB(10.w, 10.h, 5.w, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "${user.firstName} ${user.lastName}",
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.t.s(18).w600,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          lastMessage[1],
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.t.s(12).w400.grey68,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3.w),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      lastMessage[0],
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.t.s(16).w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
