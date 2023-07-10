import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_widget/chat_widget_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/helpers/logger.dart';
import '../../../home/home_screens.dart';

class DocumentChat extends StatefulWidget {
  const DocumentChat(
      {Key? key,
      required this.documentName,
      required this.isOutgoing,
      required this.idDocument,
      required this.isAvt})
      : super(key: key);
  final String documentName;
  final bool isOutgoing;
  final int idDocument;
  final bool isAvt;
  @override
  State<DocumentChat> createState() => _DocumentChatState();
}

class _DocumentChatState extends State<DocumentChat> {
  String folderSavePath = "";
  bool isNewPath = false;
  @override
  Widget build(BuildContext context) {
  final viewModel = context.watch<ChatWidgetViewModel>();
    return widget.isOutgoing
        ? Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () async {
                            viewModel.downloadAndSaveFile(
                              widget.idDocument,
                              docummentPath,
                              widget.documentName,
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  "assets/icons/document.png",
                                  height: 35.h,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  widget.documentName,
                                  style: const TextStyle(
                                      color: Palette.gray97,
                                      decoration: TextDecoration.underline),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () async {
                                final String? result = await getDirectoryPath();
                                if (result != null) {
                                  folderSavePath = result;
                                } else {}
                                Logger.d("check crash 1");
                              },
                              icon: Image.asset(
                                  "assets/icons/dowload_document.png")))
                    ],
                  ),
                ),
              ),
              widget.isAvt
                  ? Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: const CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/avt.jpeg",
                            // fit: BoxFit.cover,
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
            children: [
              widget.isAvt
                  ? Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        // margin: EdgeInsets.all(size.height * 0.015),
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
                        backgroundColor: Color.fromARGB(0, 189, 188, 188),
                      ),
                    ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: InkWell(
                          onTap: () async {
                            viewModel.downloadAndSaveFile(
                              widget.idDocument,
                              docummentPath,
                              widget.documentName,
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  "assets/icons/document.png",
                                  height: 35.h,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  widget.documentName,
                                  style: const TextStyle(
                                      color: Palette.gray97,
                                      decoration: TextDecoration.underline),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () async {
                                final String? result = await getDirectoryPath();
                                if (result != null) {
                                  folderSavePath = result;
                                } else {}
                                Logger.d("check crash 1");
                              },
                              icon: Image.asset(
                                  "assets/icons/dowload_document.png")))
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
