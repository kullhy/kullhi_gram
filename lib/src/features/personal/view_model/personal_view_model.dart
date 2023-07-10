import 'package:min_soft_ware/src/configs/base_view_model_new.dart';
import 'package:min_soft_ware/src/data/models/my_profile/user.dart';

import '../../../repository/manager_reponsitory.dart';

class PersonalViewModel extends BaseViewNewModel {
  final PersonalRepository personalRP;

  PersonalViewModel({required this.personalRP}) : super(personalRP) {
    getUserInfor();
    notifyListeners();
  }
  User? userInfor;

  void getUserInfor() {
    setLoading = true;
    personalRP.getMeInfo().then((res) {
      if (res.status?.code == 200) {
        userInfor = res.user;
      } else {
        showError("Tải Thông tin không thành công");
      }
    });
    setLoading = false;
    notifyListeners();
  }
}
