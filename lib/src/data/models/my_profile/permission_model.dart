// To parse this JSON data, do
//
//     final permissionsModel = permissionsModelFromJson(jsonString);

import 'dart:convert';

import 'package:min_soft_ware/src/data/models/my_profile/status.dart';

PermissionsModel permissionsModelFromJson(String str) => PermissionsModel.fromJson(json.decode(str));

String permissionsModelToJson(PermissionsModel data) => json.encode(data.toJson());

class PermissionsModel {
    Status? status;
    List<String>? permissions;

    PermissionsModel({
        this.status,
        this.permissions,
    });

    PermissionsModel copyWith({
        Status? status,
        List<String>? permissions,
    }) =>
        PermissionsModel(
            status: status ?? this.status,
            permissions: permissions ?? this.permissions,
        );

    factory PermissionsModel.fromJson(Map<String, dynamic> json) => PermissionsModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        permissions: json["permissions"] == null ? [] : List<String>.from(json["permissions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
    };
}


