import 'package:user_app/common/constants/strings.dart';

import '../constants/enums.dart';

extension GenderParser on String {
  Gender toGender() {
    String gender = replaceAll(' ', '').toLowerCase();
    switch (gender) {
      case (maleGender):
        return Gender.male;
      case (femaleGender):
        return Gender.female;
      default:
        return Gender.undefined;
    }
  }
}

extension StatusParser on String {
  Status toStatus() {
    String status = replaceAll(' ', '').toLowerCase();
    switch (status) {
      case (activeStatus):
        return Status.active;
      case (inactiveStatus):
        return Status.inactive;
      default:
        return Status.undefined;
    }
  }
}
