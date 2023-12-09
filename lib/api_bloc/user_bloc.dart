import 'package:bloc_api/api_bloc/user_state.dart';
import 'package:bloc_api/models/user_model.dart';
import 'package:bloc_api/repository/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(InitialState()) {
    getUsers();
    if(state is LoadingApiState){
      getUsers();
    }

  }
    UserRepo userRepo = UserRepo();

    getUsers() async {
      try {
        List<UserModel> userList = await userRepo.getUser();
        emit(GetDataAPiState(userList));
      } catch (e) {
        emit(ErrorApiState(e.toString()));
      }
    }

    on_refresh(){
      emit(LoadingApiState());
      getUsers();
    }


    on_search(String value, List<UserModel> userList){
      List<UserModel>finalList=[];

       finalList = userList
          .where((contacts) => contacts.title
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
          if(value.isEmpty){
on_refresh();
                  



    }
    else{
          emit(GetDataAPiState(finalList));

    }
}
}