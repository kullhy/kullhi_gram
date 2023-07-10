import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_detail_widget/chat_detail_view_model.dart';


import '../../chat_widget/chatWidgetComponents/view_photo.dart';

class PhotoShare extends StatefulWidget {
  const PhotoShare({
    Key? key,
    required this.value,
  }) : super(key: key);
  final ChatDetailViewModel value;

  @override
  State<PhotoShare> createState() => _PhotoShareState();
}

class _PhotoShareState extends State<PhotoShare> {
  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    return ValueListenableBuilder<bool>(
        valueListenable: value.showAllNotifier,
        builder: (context, showAll, _) {
          return Container(
              padding: EdgeInsets.all(15.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text("Ảnh đã chia sẻ",
                              overflow: TextOverflow.ellipsis,
                              style: AppFont.t.s(15).w600)),
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                value.toggleShowAllPhoTo();
                              },
                              child: Text(showAll ? "Thu nhỏ" : "Xem tất cả",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFont.t.s(15).w600.blue),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 1000.h,
                    // height:,
                    width: 300.w,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                150.w, // Kích thước tối đa cho mỗi item
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 1,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: value.displayedListPhoto.length,
                          itemBuilder: (_, index) {
                            return itemPhoto(value.displayedListPhoto[index]);
                          },
                        );
                      },
                    ),
                  )
                ],
              ));
                  });
  }

  Widget itemPhoto(String photoPath) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Palette.primary),
          borderRadius: BorderRadius.circular(10), // Đặt bán kính bo cong ở đây
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageFromPath(imagePath: photoPath.replaceAll(r"\\", "/")),
        ),
      ),
      onTap: () {
        downloadAndGetPhoto(context, photoPath.replaceAll(r"\\", "/"));
      },
    );
  }
}

class ImageFromPath extends StatelessWidget {
  final String imagePath;
  const ImageFromPath({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(File(imagePath), fit: BoxFit.cover);
  }
}
