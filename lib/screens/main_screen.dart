import 'package:bloc_api/api_bloc/user_bloc.dart';
import 'package:bloc_api/api_bloc/user_state.dart';
import 'package:bloc_api/models/user_model.dart';
import 'package:bloc_api/repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<UserModel> userlist = [];

  TextEditingController search_controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    UserRepo().getUser();
  }

  List filteredData = [];


  on_refresh() {
            BlocProvider.of<ApiCubit>(context).on_refresh();  }


            on_search({required String value, required List<UserModel>userlist}){
              BlocProvider.of<ApiCubit>(context).on_search(value,userlist);

            }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: RefreshIndicator(
          onRefresh: () async {
            //loading state then get data state
            on_refresh();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: search_controller,
                  decoration: const InputDecoration(
                      suffix: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      labelText: "search",
                      hintText: "search"),
                  onChanged: (value) {
on_search(value: value, userlist: userlist)     ;             },
                ),
                Container(
                  height: 50,
                ),
                const Text("User List"),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ApiCubit, ApiState>(builder: (context, state) {
                  if (state is GetDataAPiState) {
                    userlist = state.userList;

                      return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading:
                                    Text(state.userList[index].id.toString()),
                                title: Text(
                                    state.userList[index].title.toString()),
                                subtitle:
                                    Text(state.userList[index].body.toString()),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: state.userList.length);
           

                  } else if (state is ErrorApiState) {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
