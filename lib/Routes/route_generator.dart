import 'package:flutter/material.dart';
import 'package:user_app/features/error/error_page.dart';
import 'package:user_app/features/user/list/user_list.dart';

import '../common/constants/strings.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => UserList(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => ErrorPage(),
        );
    }
  }
}
