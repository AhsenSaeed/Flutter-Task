import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fvrt_task/backend/server_response.dart';
import 'dart:io';

class SharedWebService {
  static const _BASE_URL = 'https://jsonplaceholder.typicode.com/';

  final HttpClient _client = HttpClient();
  final Duration _timeoutDuration = const Duration(seconds: 20);

  static SharedWebService? _instance;

  SharedWebService._();

  static SharedWebService instance() {
    _instance ??= SharedWebService._();
    return _instance!;
  }

  Future<HttpClientResponse> _responseFrom(
          Future<HttpClientRequest> Function(Uri) toCall,
          {required Uri uri}) =>
      toCall(uri).then((request) => request.close()).timeout(_timeoutDuration);

  Future<HttpClientResponse> _get(Uri uri) =>
      _responseFrom(_client.getUrl, uri: uri);

  Future<List<UserModel>> users() async {
    final response = await _get(Uri.parse('${_BASE_URL}users'));
    final responseBody = await response.transform(utf8.decoder).join();
    return compute(parseUsers, responseBody);
  }
}

List<UserModel> parseUsers(String responseBody) =>
    (json.decode(responseBody) as List<dynamic>)
        .map((e) => UserModel.fromJson(e))
        .toList();
