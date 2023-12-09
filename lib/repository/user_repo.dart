import 'dart:convert';

import 'package:bloc_api/models/user_model.dart';

import 'package:http/http.dart' as http;

class UserRepo {
  Future<List<UserModel>> getUser() async {
    List<UserModel> userList = [];

    
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      if (response.statusCode == 200) {
        List responseUserList = jsonDecode(response.body.toString());
        responseUserList.forEach((e) {
          userList.add(UserModel.fromJson(e));
        });
        if (userList.isNotEmpty) {
          return  userList;
        } else {
          return [];
        }
      } 
      return [];
  
  }
}
