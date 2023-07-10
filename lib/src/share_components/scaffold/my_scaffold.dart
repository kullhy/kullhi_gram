
import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/configs/palette.dart';

class MyScaffoldWidget extends StatelessWidget {
  const MyScaffoldWidget(
      {super.key,
      this.appBar,
      this.bodyApp,
      this.backgroundColor,
      this.bottomNavigatorWidget,
      this.drawer,
      this.resizeToAvoidBottomInset});

  final PreferredSizeWidget? appBar;
  final Widget? bodyApp;
  final Widget? bottomNavigatorWidget;
  final Color? backgroundColor;
  final Widget? drawer;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? Palette.white,
      body: bodyApp,
      bottomNavigationBar: bottomNavigatorWidget,
      drawer: drawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
    ));
  }
}
