

import 'dart:convert';

import 'package:min_soft_ware/src/data/models/my_profile/status.dart';
import 'package:min_soft_ware/src/data/models/my_profile/user.dart';



UserInPermissonModel getUserInPermissonModelFromJson(String str) =>UserInPermissonModel.fromJson(json.decode(str));

String getUserInPermissonModelToJson(UserInPermissonModel data) => json.encode(data.toJson());

class UserInPermissonModel {
    Status? status;
    List<User>? users;

    UserInPermissonModel({
        this.status,
        this.users,
    });

    UserInPermissonModel copyWith({
        Status? status,
        List<User>? users,
    }) =>
        UserInPermissonModel(
            status: status ?? this.status,
            users: users ?? this.users,
        );

    factory UserInPermissonModel.fromJson(Map<String, dynamic> json) => UserInPermissonModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}




