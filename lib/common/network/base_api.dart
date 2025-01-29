import 'dart:io';

import 'package:user_app/common/constants/strings.dart';
import 'package:http/http.dart' as http_client;

class BaseApi {
  final httpClient = http_client.Client();
  Uri getUri(String endpoint) {
    return Uri.parse('$gorestBaseUrl$endpoint');
  }

  void _handleError(http_client.Response response) {
    switch (response.statusCode) {
      case (>= 400 && < 500):
        throw '$clientErrorMessage (${response.statusCode})';
      case (>= 500):
        throw '$serverErrorMessage (${response.statusCode})';
      default:
        throw '$unexpectedErrorMessage (${response.statusCode})';
    }
  }

  Future<http_client.Response> send(
      Future<http_client.Response> request) async {
    try {
      final response = await request;
      if (response.statusCode != 200) _handleError(response);
      return response;
    } on SocketException catch (_) {
      throw noInternetErrorMessage;
    } catch (e) {
      throw e.toString();
    }
  }
}
