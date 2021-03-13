import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/data/remote/api/api_service.dart';
import '../../lib/data/remote/model/detail_model.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  final Dio tdio = Dio();
  DioAdapterMock dioAdapterMock;
  var apiService = ApiServiceImpl();

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    tdio.httpClientAdapter = dioAdapterMock;
    apiService = ApiServiceImpl(dio: tdio);
  });

  test('Fetch detail list', () async {
    final responsepayload = jsonEncode({
      "error": false,
      "message": "success",
    });
    final httpResponse = ResponseBody.fromString(
      responsepayload,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(dioAdapterMock.fetch(any, any, any))
        .thenAnswer((_) async => httpResponse);

    var response = await apiService.fetchDetail('rqdv5juczeskfw1e867');

    var expected = DetailModel(error: false, message: "success");

    expect(response.message, expected.message);
  });
}
