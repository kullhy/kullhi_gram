import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/Palette.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/box.dart';
import 'package:min_soft_ware/src/features/login/view_model/login_view_model.dart';
import 'package:min_soft_ware/src/share_components/text_feild/my_text_field.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';
import '../../../services/telegram_service.dart';
import '../../../share_components/button/buttom_primary.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final viewModel = context.watch<LoginViewModel>();
    final telegramService = context.watch<TelegramService>();
    return Scaffold(
      backgroundColor: Palette.white,
      body: Platform.isAndroid
          ? Column(
              children: [
                const Spacer(),
                Assets.image.logo.image(height: height * 0.3, width: width * 0.7),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("LOGIN WITH PHONE NUMBER", style: AppFont.t.s(16).w600.grey68),
                      BoxMain.h(16),
                      MyTextField(
                          suffixIcon: const Icon(Icons.arrow_drop_down_rounded, color: Palette.black),
                          controller: viewModel.countryNameController,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Theme(
                                data: Theme.of(context).copyWith(primaryColor: Colors.pink),
                                child: CountryPickerDialog(
                                    titlePadding: const EdgeInsets.all(8.0),
                                    searchCursorColor: Colors.pinkAccent,
                                    searchInputDecoration: const InputDecoration(hintText: 'Search...'),
                                    isSearchable: true,
                                    title: const Text('Select your phone code'),
                                    onValuePicked: viewModel.onPickCountry,
                                    itemBuilder: _buildDialogItem),
                              ),
                            );
                          },
                          labelText: "Country",
                          readOnly: true),
                      BoxMain.h(32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                                titleStyle: AppFont.t.s(16).w600,
                                prefixText: "(viewModel.selectedCountry != null) ? '+${viewModel.selectedCountry!.phoneCode}  ' : ' +  '",
                                controller: viewModel.phoneNumberController,
                                keyboardType: TextInputType.number,
                                inputBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                                onSubmit: (value) => viewModel.nextStep(value),
                                autoFocus: true),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(viewModel.phoneNumberError == null ? 'We will send a SMS with a confirmation code to your phone number.' : '',
                              style: const TextStyle(color: Colors.grey, fontSize: 15.0))),
                      TextButton(
                        onPressed: () {
                          telegramService.requestQR(onError: (value) => viewModel.handelError(value));
                        },
                        child: const Text("Login with QR"),
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            )
          : Row(children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Palette.primary.withOpacity(0.5), // Màu sắc của đổ bóng
                        spreadRadius: 5, // Bán kính mở rộng của đổ bóng
                        blurRadius: 7, // Độ mờ của đổ bóng
                        offset: const Offset(0, 3)),
                  ],
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
                  color: Palette.primary,
                ),
                height: height,
                width: width * 1 / 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(child: Assets.image.logo.image(height: 200.h, width: 200.w)),
                ),
              ),

              Expanded(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    height: height * 0.8,
                    width: width * 1 / 3,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
                          Text("LOGIN WITH PHONE NUMBER", style: AppFont.t.s(16).black.w600),
                          BoxMain.h(50),
                          MyTextField(
                            titleStyle: AppFont.t.s(16).w600,
                            hasBorder: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Theme(
                                  data: Theme.of(context).copyWith(primaryColor: Colors.pink),
                                  child: CountryPickerDialog(
                                    titlePadding: const EdgeInsets.all(8.0),
                                    searchCursorColor: Colors.pinkAccent,
                                    searchInputDecoration: const InputDecoration(hintText: 'Search...'),
                                    isSearchable: true,
                                    title: const Text('Select your phone code'),
                                    onValuePicked: viewModel.onPickCountry,
                                    itemBuilder: _buildDialogItem,
                                  ),
                                ),
                              );
                            },
                            fillColor: Palette.grayF6,
                            hintStyle: AppFont.t.s(16).grey68,
                            hintText: "Country",
                            inputBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            controller: viewModel.countryNameController,
                            style: AppFont.t.w600,
                            title: "Country",
                            readOnly: true,
                          ),
                          BoxMain.h(40),
                          MyTextField(
                            style: AppFont.t.s(16).w600,
                            hasBorder: true,
                            controller: viewModel.phoneNumberController,
                            keyboardType: TextInputType.number,
                            hintText: "+84",
                            title: "Phone",
                            maxLength: 10,
                            focusNode: viewModel.focusNodephoneNumbe,
                            inputBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            onSubmit: viewModel.nextStep,
                            autoFocus: true,
                            fillColor: Palette.grayF6,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              viewModel.phoneNumberError == null ? 'We will send a SMS with a confirmation code to your phone number.' : '',
                              style: const TextStyle(color: Colors.grey, fontSize: 15.0),
                            ),
                          ),
                          const Spacer(),
                          ButtonPrimary(
                            color: Palette.black,
                            text: "Login",
                            action: () => telegramService.requestQR(onError: viewModel.handelError),
                          ),
                          TextButton(
                            onPressed: () {
                              viewModel.onChangeQr();
                              // telegramService.requestQR(onError: viewModel.handelError);
                            },
                            child: Text(
                              "Login with QR",
                              style: AppFont.t.w600.blue,
                            ),
                          ),
                          const Spacer(),
                        ])))
              ]))

              // const Spacer(),
            ]),

      floatingActionButton: viewModel.canShowButton
          ? FloatingActionButton(
              onPressed: () => viewModel.nextStep(viewModel.phoneNumberController.text),
              tooltip: 'checkphone',
              child: viewModel.loadingStep
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    )
                  : const Icon(Icons.navigate_next),
            )
          : null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildDialogItem(Country country) {
    return Row(children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      const SizedBox(width: 8.0),
      Text("+${country.phoneCode}"),
      const SizedBox(width: 8.0),
      Flexible(
        child: Text(country.name),
      )
    ]);
  }
}
