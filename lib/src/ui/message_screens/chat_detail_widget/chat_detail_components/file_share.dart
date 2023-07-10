import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/ui/home/home_screens.dart';
import 'package:min_soft_ware/src/ui/message_screens/chat_detail_widget/chat_detail_view_model.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:provider/provider.dart';

class FileShare extends StatefulWidget {
  const FileShare({Key? key, required this.value}) : super(key: key);
  final ChatDetailViewModel value;

  @override
  State<FileShare> createState() => _FileShareState();
}

class _FileShareState extends State<FileShare> {
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
                    child: Text(
                      "File đã chia sẻ",
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.t.s(15).w600,
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          value.toggleShowAllFile();
                          Logger.d("check showall", value.showAll);
                        },
                        child: Text(
                          showAll ? "Thu nhỏ" : "Xem tất cả",
                          overflow: TextOverflow.ellipsis,
                          style: AppFont.t.s(14).w600.blue,
                        ),
                      ),
                    )),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: value.displayedList.length,
              itemBuilder: (context, index) {
                Logger.d("check showall", value.displayedList.length);
                return itemDocument(value.displayedList[index].id!,
                    docummentPath, value.displayedList[index].name!);
              },
            ),
          ],
        ));
      },
    );
  }

  Widget itemDocument(
      int idDocument, String docummentPath, String documentName) {
    final value = context.watch<ChatDetailViewModel>();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 6,
              child: InkWell(
                onTap: () async {
                  Logger.d("change fileShare", idDocument);

                  value.downloadAndSaveFile(
                    idDocument,
                    docummentPath,
                    documentName,
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
                        documentName,
                        style: AppFont.t.grey68.s(12),
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
                      value.dowloadDocument(idDocument, documentName);
                    },
                    icon: Image.asset("assets/icons/dowload_document.png")))
          ],
        ),
        Container(
          // padding: const EdgeInsets.only(top: 15, bottom: 15),
          height: 2,
          color: Palette.grayBE,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
