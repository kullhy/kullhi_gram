import 'status.dart';
import 'user.dart';

class MyProfile {
  Status? status;
  User? user;

  MyProfile({this.status, this.user});

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        status: json['status'] == null
            ? null
            : Status.fromJson(json['status'] as Map<String, dynamic>),
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
        'user': user?.toJson(),
      };
}
