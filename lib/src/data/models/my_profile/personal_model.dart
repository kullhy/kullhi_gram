
import 'dart:convert';

import 'package:min_soft_ware/src/data/models/my_profile/status.dart';
import 'package:min_soft_ware/src/data/models/my_profile/user.dart';

PersonalModel personalModelFromJson(String str) => PersonalModel.fromJson(json.decode(str));

String personalModelToJson(PersonalModel data) => json.encode(data.toJson());

class PersonalModel {
     Status? status;
     User? user;

    PersonalModel({
        this.status,
        this.user,
    });

    PersonalModel copyWith({
        Status? status,
        User? user,
    }) =>
        PersonalModel(
            status: status ?? this.status,
            user: user ?? this.user,
        );

    factory PersonalModel.fromJson(Map<String, dynamic> json) => PersonalModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "user": user?.toJson(),
    };
}




