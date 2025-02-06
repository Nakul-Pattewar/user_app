import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:user_app/features/user/list/network/user_api.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late String json;
  late UserApi userApi;

  setUpAll(() async {
    registerFallbackValue(Uri());
    mockClient = MockClient();
    userApi = UserApi(client: mockClient);
    json = jsonEncode([
      {
        "id": 7646618,
        "name": "Prof. Mohini Varrier",
        "email": "prof_mohini_varrier@grady-trantow.test",
        "gender": "female",
        "status": "inactive"
      },
      {
        "id": 7646617,
        "name": "Paramartha Trivedi",
        "email": "trivedi_paramartha@hickle-lowe.example",
        "gender": "female",
        "status": "active"
      },
      {
        "id": 7646616,
        "name": "Bhadrak Joshi",
        "email": "bhadrak_joshi@howe-waelchi.test",
        "gender": "male",
        "status": "active"
      },
      {
        "id": 7646615,
        "name": "Rep. Madhuri Mishra",
        "email": "mishra_rep_madhuri@rosenbaum-glover.test",
        "gender": "female",
        "status": "inactive"
      },
      {
        "id": 7646614,
        "name": "Lakshmi Pothuvaal DVM",
        "email": "lakshmi_dvm_pothuvaal@goyette.example",
        "gender": "female",
        "status": "inactive"
      },
      {
        "id": 7646613,
        "name": "Anand Singh",
        "email": "anand_singh@tillman.test",
        "gender": "female",
        "status": "active"
      },
      {
        "id": 7646348,
        "name": "Baalagopaal Bandopadhyay Sr.",
        "email": "bandopadhyay_baalagopaal_sr@jacobi.example",
        "gender": "female",
        "status": "inactive"
      },
      {
        "id": 7646346,
        "name": "Vidya Devar",
        "email": "devar_vidya@thiel-schneider.test",
        "gender": "male",
        "status": "inactive"
      },
      {
        "id": 7646345,
        "name": "Chidaakaash Reddy",
        "email": "reddy_chidaakaash@zulauf.test",
        "gender": "male",
        "status": "inactive"
      },
      {
        "id": 7646344,
        "name": "Sen. Deveshwar Bharadwaj",
        "email": "deveshwar_bharadwaj_sen@thompson.example",
        "gender": "male",
        "status": "active"
      },
      {
        "id": 7646389,
        "name": "Sen. Deveshwar Bharadwaj",
        "email": "deveshwar_bharadwaj_sen@thompson.example",
        "gender": "male",
        "status": "active"
      },
      {
        "id": 7646389,
        "name": "Sen. Deveshwar Bharadwaj",
        "email": "deveshwar_bharadwaj_sen@thompson.example",
        "gender": "male",
        "status": "active"
      }
    ]).toString();
  });

  group("tests for UserApi", () {
    test(
        "Given user api response,"
        "When get call occurs,"
        "Then should return list with all users", () async {
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(json, 200),
      );

      final userList = await userApi.getUsersList();
      expect(userList.length, 12);
    });

    test(
        "Given empty user API response, "
        "when GET call occurs, "
        "then should return an empty list", () async {
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([]).toString(), 200),
      );

      final userList = await userApi.getUsersList();
      expect(userList, []);
    });

    test(
        "Given manipulated JSON, "
        "when GET call occurs, "
        "then should throw FormatException", () async {
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response("{manipulated_json}", 200),
      );

      expect(() async => await userApi.getUsersList(), throwsFormatException);
    });

    test(
        "Given API error response, "
        "when GET call occurs, "
        "then should throw Exception", () async {
      when(() => mockClient.get(any())).thenThrow(Exception());

      expect(
          () async => await userApi.getUsersList(), throwsA(isA<Exception>()));
    });

    test(
        "Given null response body, "
        "when GET call occurs, "
        "then should throw FormatException", () async {
      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response("", 200),
      );

      expect(() async => await userApi.getUsersList(), throwsFormatException);
    });

    test(
        "Given invalid data type in JSON, "
        "when GET call occurs, "
        "then should throw TypeError", () async {
      final invalidJson = jsonEncode([
        {
          "id": "invalid_id",
          "name": 123,
          "email": true,
          "gender": {},
          "status": []
        }
      ]);

      when(() => mockClient.get(any())).thenAnswer(
        (_) async => http.Response(invalidJson, 200),
      );

      expect(
          () async => await userApi.getUsersList(), throwsA(isA<TypeError>()));
    });
  });
}
