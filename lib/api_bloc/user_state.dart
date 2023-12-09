

import 'package:bloc_api/models/user_model.dart';
import 'package:flutter/material.dart';

@immutable


abstract class ApiState{}




class LoadingApiState extends ApiState{


}
class GetDataAPiState extends ApiState{
  final List<UserModel> userList;
  GetDataAPiState(this.userList);


}
class ErrorApiState extends ApiState{
  final String erroMessage;
  ErrorApiState(this.erroMessage);


}
class InitialState extends ApiState{
  


}