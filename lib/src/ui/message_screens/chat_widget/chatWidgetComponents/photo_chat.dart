import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_widget/chatWidgetComponents/view_photo.dart';

class PhotoChat extends StatefulWidget {
  const PhotoChat(
      {Key? key,
      required this.dataPhoto,
      required this.idPhoto,
      required this.pathPhoto,
      required this.isAvt,
      required this.isOutgoing})
      : super(key: key);
  final String dataPhoto;
  final int idPhoto;
  final String pathPhoto;
  final bool isAvt;
  final bool isOutgoing;
  @override
  State<PhotoChat> createState() => _photoChatState();
}

// ignore: camel_case_types
class _photoChatState extends State<PhotoChat> {
  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(widget.dataPhoto);
    Widget imageWidget = Image.memory(
      bytes,
      width: 700.w,
    );
    return widget.isOutgoing
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.primary),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: widget.pathPhoto == ""
                        ? imageWidget
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageFromPath(
                                imagePath:
                                    widget.pathPhoto.replaceAll(r"\\", "/")),
                          ),
                  ),
                  onTap: () {
                    downloadAndGetPhoto(
                        context, widget.pathPhoto.replaceAll(r"\\", "/"));
                  }),
              widget.isAvt
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.all(15.w),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/avt.jpeg",
                          ),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(15.w),
                      child: const CircleAvatar(
                        backgroundImage: null,
                        backgroundColor: Palette.transparent,
                      ),
                    ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.isAvt
                  ? Container(
                      margin: EdgeInsets.all(15.w),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/avt.jpeg",
                          // fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(15.w),
                      child: const CircleAvatar(
                        backgroundImage: null,
                        backgroundColor: Palette.transparent,
                      ),
                    ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.primary),
                    borderRadius:
                        BorderRadius.circular(10), // Đặt bán kính bo cong ở đây
                  ),
                  child: widget.pathPhoto == ""
                      ? imageWidget
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ImageFromPath(
                              imagePath:
                                  widget.pathPhoto.replaceAll(r"\\", "/")),
                        ),
                ),
                onTap: () {
                  downloadAndGetPhoto(
                      context, widget.pathPhoto.replaceAll(r"\\", "/"));
                },
              ),
            ],
          );
  }
}

class ImageFromPath extends StatelessWidget {
  final String imagePath;

  const ImageFromPath({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(File(imagePath), width: 150.w, fit: BoxFit.cover);
  }
}
