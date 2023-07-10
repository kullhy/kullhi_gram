import 'package:min_soft_ware/src/data/models/my_profile/status.dart';
import 'package:min_soft_ware/src/data/models/my_profile/user.dart';
import 'package:min_soft_ware/src/network/api_path.dart';
import 'package:min_soft_ware/src/repository/repository.dart';

import '../data/models/my_profile/permission_model.dart';
import '../data/models/my_profile/personal_model.dart';
import '../data/models/my_profile/user_permisson_model.dart';

class PersonalRepository extends Repository {
  Future<PersonalModel> getMeInfo() async {
    PersonalModel personal = PersonalModel();
    await dioHelper.get(ApiPath.getMe).then(
      (res) async {
        personal.status = Status.fromJson(res.data['status']);
        if (personal.status?.code == 200 && personal.status?.message == 'sucess') {
          personal.user = User.fromJson(res.data["user"]);
        }
      },
    );
    return personal;
  }

  Future<PermissionsModel> getPermissions() async {
    PermissionsModel permissions = PermissionsModel();
    await dioHelper.get(ApiPath.getMe).then(
      (res) async {
        List<String> list = [];
        permissions.status = Status.fromJson(res.data['status']);
        if (permissions.status?.code == 200 && permissions.status?.message == 'sucess') {
          for (var s in res.data['permissions']) {
            list.add(s);
          }
          permissions.permissions = list;
        }
      },
    );
    return permissions;
  }

  Future<UserInPermissonModel> getUserInPerrmisson() async {
    UserInPermissonModel permissions = UserInPermissonModel();
    await dioHelper.get(ApiPath.getMe).then(
      (res) async {
        List<User> listUser = [];
        permissions.status = Status.fromJson(res.data['status']);
        if (permissions.status?.code == 200 && permissions.status?.message == 'sucess') {
          for (var s in res.data['permissions']) {
            listUser.add(User.fromJson(s));
          }
        }
        permissions.users = listUser;
      },
    );
    return permissions;
  }
}
