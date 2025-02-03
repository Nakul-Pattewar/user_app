import 'package:user_app/common/constants/strings.dart';

import '../constants/enums.dart';

extension GenderParser on String {
  Gender toGender() {
    switch (this) {
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
    switch (this) {
      case (activeStatus):
        return Status.active;
      case (inactiveStatus):
        return Status.inactive;
      default:
        return Status.undefined;
    }
  }
}
