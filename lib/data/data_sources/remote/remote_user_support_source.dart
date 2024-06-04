import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/user_support.dart';
import 'package:http/http.dart' as http;

import 'i_remote_user_support_source.dart';

class RemoteUserSupportSource implements IRemoteUserSupportSource {
  final http.Client httpClient;
  final String apiKey = 'SIxBXD';

  RemoteUserSupportSource({http.Client? client})
      : httpClient = client ?? http.Client();

  @override
  Future<List<UserSupport>> getUsers() async {
    List<UserSupport> users = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/UserSupport")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await httpClient.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      users = List<UserSupport>.from(data.skip(1).map((x) => UserSupport.fromJson(x)));
      //users.removeAt(1);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(users);
  }

  @override
  Future<bool> addUser(UserSupport user_support) async {
    logInfo("Web service, Adding user_support");

    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/UserSupport"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user_support.toJson()),
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
  Future<bool> updateUser(UserSupport user_support) async {
    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/UserSupport/${user_support.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user_support.toJson()),
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
  Future<bool> deleteUser(int id) async {
    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/UserSupport/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    logInfo("Deleting user_support with id $id status code ${response.statusCode}");
    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteUsers() async {
    List<UserSupport> users = await getUsers();
    for (var user_support in users) {
      await deleteUser(user_support.id!);
    }
    return Future.value(true);
  }
}