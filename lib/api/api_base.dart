import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies_list/api/api_exception.dart';

class ApiBase {
  final String _baseUrl = "http://api.themoviedb.org/3/";
  Future<dynamic> get(String url, String accessToken) async {
    late dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url),
          headers: {"Authorization": "Bearer $accessToken"});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> search_query(String query, String accessToken) async {
    late dynamic responseJson;
    try {
      final response = await http.get(
          Uri.parse("${_baseUrl}search/movie?query=$query"),
          headers: {"Authorization": "Bearer $accessToken"});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
