import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit_1/application/skill/cubit/user_cubit.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({Key? key, @required this.id}) : super(key: key);
  final int? id;

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  var userDetail;
  int? tempId;

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
                    print("State status : $state");
                    if (state is SkillLoading) {
                      print('Loading');
                    } else if (state is SkillError) {
                      print(state.errorMessage);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Error"),
                                content: Text(state.errorMessage),
                              ));
                    } else if (state is UserDetailSuccess) {
                      print('Get user detail success');
                      userDetail = state.getDetail.data;
                      print(userDetail.id);
                    }
                  },
                  builder: (context, state) {
                    tempId = widget.id;
                    if (state is SkillInitial) {
                      // final _requestData = UserDetailRequest(id: 2);
                      context.read<SkillCubit>().getDetailUser(tempId);
                    } else if (state is SkillLoading) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue[400],
                          ),
                        ),
                      );
                    } else if (state is UserDetailSuccess) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ID"),
                                Text("Email"),
                                Text("First Name"),
                                Text("Last Name"),
                                Text("Avatar"),
                              ],
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(": ${userDetail.id}"),
                                  Text(": ${userDetail.email}"),
                                  Text(": ${userDetail.firstName}"),
                                  Text(": ${userDetail.lastName}"),
                                  Text(
                                    ": ${userDetail.avatar}",
                                    style: TextStyle(fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue[400],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
