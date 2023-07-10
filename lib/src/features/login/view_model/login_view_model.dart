import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';

import 'package:min_soft_ware/src/configs/base_view_model_new.dart';
import 'package:min_soft_ware/src/utils/helpers/logger.dart';
import 'package:provider/provider.dart';
import 'package:tdlib/td_api.dart';

import '../../../repository/repository.dart';
import '../../../services/telegram_service.dart';

class LoginViewModel extends BaseViewNewModel {
  @override
  
  LoginViewModel({required this.repository}) : super(repository) {
    focusNodephoneNumbe.addListener(trimSpacePhoneNumber);
  }
  @override
  final Repository repository;
  late Widget platform;
  final phoneNumberController = TextEditingController();
  final countryNameController = TextEditingController();
  Country? selectedCountry;
  bool canShowButton = false;
  String? phoneNumberError;
  bool authenQr = false;
  bool loadingStep = false;
  bool isAndroid = false;
  GlobalKey<FormState> formLogin = GlobalKey<FormState>();
  FocusNode focusNodephoneNumbe = FocusNode();
  FocusNode focusNodeCounTry = FocusNode();
  void trimSpacePhoneNumber() {
    if (!focusNodephoneNumbe.hasFocus) {
      phoneNumberController.text = phoneNumberController.text.replaceAll(' ', '');
      notifyListeners();
    }
  }

  void onPickCountry(Country country) {
    selectedCountry = country;
    countryNameController.text = country.name;
    notifyListeners();
  }

  void nextStep(String value) async {
    loadingStep = true;
    notifyListeners();

    curContext.read<TelegramService>().setAuthenticationPhoneNumber(
          (selectedCountry != null) ? '+${selectedCountry!.phoneCode}$value' : value,
          onError: handelError,
        );
  }

  void handelError(TdError error) async {
    loadingStep = false;
    phoneNumberError = error.message;
    notifyListeners();
  }

  void onChangeQr() {
    authenQr = !authenQr;
    Logger.d("authenQr", authenQr);
    notifyListeners();
  }
}
