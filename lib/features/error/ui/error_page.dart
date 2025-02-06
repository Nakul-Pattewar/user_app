import 'package:flutter/material.dart';

import '../../../common/constants/strings.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          errorPageTitle,
        ),
      ),
      body: Center(
        child: Text(
          errorPageTitle,
        ),
      ),
    );
  }
}
