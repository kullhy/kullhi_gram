// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:min_soft_ware/src/configs/app_fonts.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:provider/provider.dart';

import 'package:tdlib/td_api.dart' show TdError;

import '../../services/telegram_service.dart';

class CodeEntryScreen extends StatefulWidget {
  const CodeEntryScreen({Key? key}) : super(key: key);

  @override
  _CodeEntryScreenState createState() => _CodeEntryScreenState();
}

class _CodeEntryScreenState extends State<CodeEntryScreen> {
  final String title = 'Submit Code';
  final TextEditingController _codeController = TextEditingController();
  bool _canShowButton = false;
  String? _codeError;
  bool _loadingStep = false;

  void codeListener() {
    if (_codeController.text.isNotEmpty && _codeController.text.length == 5) {
      setState(() => _canShowButton = true);
    } else {
      setState(() => _canShowButton = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _codeController.addListener(codeListener);
  }

  @override
  void dispose() {
    super.dispose();
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(30.h),
        child: Center(
          child: TextField(
            maxLength: 5,
            controller: _codeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                labelText: "code",
                errorText: _codeError,
                errorStyle: AppFont.t.s(14)
                ),
            onSubmitted: _nextStep,
            autofocus: true,
          ),
        ),
      ),
      floatingActionButton: _canShowButton
          ? FloatingActionButton(
              onPressed: () => _nextStep(_codeController.text),
              tooltip: 'checkcode',
              child: _loadingStep
                  ? const CircularProgressIndicator(
                      backgroundColor: Palette.primary,
                    )
                  : const Icon(Icons.navigate_next),
            )
          : null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _nextStep(String value) async {
    setState(() {
      _loadingStep = true;
    });
    context.read<TelegramService>().checkAuthenticationCode(
          value,
          onError: _handelError,
        );
  }

  void _handelError(TdError error) async {
    setState(() {
      _loadingStep = false;
      _codeError = error.message;
    });
  }
}
