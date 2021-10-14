import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_1/application/skill/cubit/user_cubit.dart';
import 'package:flutter_cubit_1/domain/auth/model/login_response.dart';
import 'package:flutter_cubit_1/infrastructure/user/user_repository.dart';
import 'package:flutter_cubit_1/presentation/home/user_detail_page.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, @required this.loginResponse}) : super(key: key);
  LoginResponse? loginResponse;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tempList;
  final getIt = GetIt.instance;
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              BlocProvider(
                create: (context) => SkillCubit(),
                child: BlocConsumer<SkillCubit, SkillState>(
                    listener: (context, state) {
                  if (state is SkillLoading) {
                    print("Loading skill");
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(SnackBar(content: Text("Loading")));
                  } else if (state is SkillError) {
                    print(state.errorMessage);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text(state.errorMessage),
                            ));
                  } else if (state is SkillGetSuccess) {
                    print("Get skill success");
                    print(state.getData.data);
                    tempList = state.getData.data;
                    print(tempList);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("Gat data success")));
                  }
                }, builder: (context, state) {
                  print("state status : $state");
                  // context.read<SkillCubit>().getSkills();
                  if (state is SkillInitial) {
                    context.read<SkillCubit>().getSkills();
                  }
                  // else if (state is SkillGetSuccess) {
                  return Container(
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 60,
                              child: Row(
                                children: [
                                  Text(widget.loginResponse!.token),
                                  Spacer(),
                                  Container(
                                    width: 50,
                                    child: Hero(
                                      tag: 'hero',
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 80,
                                        child: Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/25/25231.png"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Container(
                                  child: IconButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      context.read<SkillCubit>().getSkills();
                                    },
                                    icon: Icon(Icons.refresh),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            height: 150,
                            color: Colors.grey[200],
                            child: (tempList != null)
                                ? (state is SkillLoading)
                                    ? Container(
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: tempList.length,
                                        itemBuilder: (context, i) {
                                          return GestureDetector(
                                            onTap: () {
                                              print(
                                                  "ID ${tempList[i].id} tapped!");
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserDetailPage(
                                                            id: tempList[i].id,
                                                          )));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              color: Colors.white,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${tempList[i].firstName} ${tempList[i].lastName}"),
                                                      Text(
                                                          "${tempList[i].email}"),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Text("${tempList[i].id}"),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
