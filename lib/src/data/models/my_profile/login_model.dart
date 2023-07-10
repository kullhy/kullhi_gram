

import 'dart:convert';

import 'package:min_soft_ware/src/data/models/my_profile/status.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    Status? status;
    String? token;

    LoginModel({
        this.status,
        this.token,
    });

    LoginModel copyWith({
        Status? status,
        String? token,
    }) =>
        LoginModel(
            status: status ?? this.status,
            token: token ?? this.token,
        );

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "token": token,
    };
}

