import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:provider/provider.dart';

import 'components/add_contact.dart';
import 'components/contact_item.dart';
import 'list_contacts_view_model.dart';

class ListContactsWidget extends StatefulWidget {
  const ListContactsWidget({Key? key, required this.onChatIdSelected})
      : super(key: key);
  final Function(int, String) onChatIdSelected;

  @override
  State<ListContactsWidget> createState() => _ListContactsWidgetState();
}

class _ListContactsWidgetState extends State<ListContactsWidget> {
  // ListContactsViewModel viewModel = ListContactsViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<ListContactsViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: 300.w,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.w),
              alignment: Alignment.centerLeft,
              child: const Text("Tin nhắn",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5.h, 10.w, 5.h, 10.w),
              padding: EdgeInsets.all(5.w),
              width: 280.w,
              height: 60.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200]),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      weight: 30.w,
                      size: 30.w,
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.only(left: 5.w, bottom: 5.h),
                      padding: EdgeInsets.all(5.h),
                      child: TextField(
                        onChanged: (value) {
                          viewModel.searchQuery = value;
                          viewModel.filterUsers();
                          viewModel.selectedItems.clear();
                        },
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          hintText: 'Tìm kiếm người dùng',
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Consumer<ListContactsViewModel>(
              builder: (context, value, child) {
                final filteredUsers = value.filteredUsers;
                return Expanded(
                  child: ListView.builder(
                    itemCount: value.filteredUsers.length,
                    itemBuilder: (context, index) {
                      Logger.d("List", value.filteredUsers.length);
                      Logger.d("list contacts", jsonEncode(filteredUsers));
                      List<String> lastMessage =
                          value.lastMessages[filteredUsers[index].id] ??
                              [" ", " "];
                      bool isSelected = value.selectedItems.contains(index);
                      return InkWell(
                          onTap: () {
                            Logger.d("selectedItems", value.selectedItems);

                            value.selectedItems
                                .clear(); // Bỏ chọn nếu đã được chọn trước đó

                            value.selectedItems
                                .add(index); // Chọn nếu chưa được chọn trước đó

                            widget.onChatIdSelected(filteredUsers[index].id,
                                filteredUsers[index].firstName);
                          },
                          child: ContactItems(
                            user: filteredUsers[index],
                            isSelected: isSelected,
                            lastMessage: lastMessage,
                          ));
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.primary,
        onPressed: () {
          addContactDiaLog(viewModel.curContext);
        },
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
