import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/normal_user.dart';
import 'package:http/http.dart' as http;

import 'i_remote_normal_user_source.dart';

class RemoteNormalUserSource implements IRemoteNormalUserSource {
  final http.Client httpClient;
  final String apiKey = 'fJsAHd';
  
  RemoteNormalUserSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<NormalUser>> getNormalUsers() async {
    List<NormalUser> normal_users = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/NormalUser")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await httpClient.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      normal_users = List<NormalUser>.from(data.skip(1).map((x) => NormalUser.fromJson(x)));
      //normal_users.removeAt(1);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
    logInfo('NormalUsers fetched: $normal_users');
    return Future.value(normal_users);
  }

  @override
  Future<NormalUser> getNormalUser(id) async {
    NormalUser normal_user ;
    var request = Uri.parse("https://retoolapi.dev/$apiKey/NormalUser/$id")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await httpClient.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      normal_user = NormalUser.fromJson(data);
      //normal_users.removeAt(1);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
    logInfo('NormalUsers fetched: $normal_user');
    return Future.value(normal_user);
  }

  @override
  Future<bool> addNormalUser(NormalUser normal_user_support) async {
    logInfo("Web service, Adding normal_user_support");

    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/NormalUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(normal_user_support.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      logError(response.body);
      return Future.value(false);
    }
  }



  @override
  Future<bool> updateNormalUser(NormalUser normal_user_support) async {
    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/NormalUser/${normal_user_support.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(normal_user_support.toJson()),
    );

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteNormalUser(int id) async {
    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/NormalUser/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    logInfo("Deleting normal_user_support with id $id status code ${response.statusCode}");
    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteNormalUsers() async {
    List<NormalUser> normal_users = await getNormalUsers();
    for (var normal_user_support in normal_users) {
      await deleteNormalUser(normal_user_support.id!);
    }
    return Future.value(true);
  }
}