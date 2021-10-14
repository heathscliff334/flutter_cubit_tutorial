import 'package:bloc/bloc.dart';

import 'package:flutter_cubit_1/domain/user/model/user_detail_response.dart';
import 'package:flutter_cubit_1/domain/user/model/user_list_response.dart';
import 'package:flutter_cubit_1/infrastructure/user/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class SkillCubit extends Cubit<SkillState> {
  SkillCubit() : super(SkillInitial());
  UserRepository _userRepository = new UserRepository();

  void getSkills() async {
    emit(SkillLoading());

    try {
      final _data = await _userRepository.getUserSkills();
      print("Try get skill");

      _data.fold(
        (l) => emit(SkillError(l)),
        (r) => emit(SkillGetSuccess(r)),
      );
    } catch (e) {
      print("Catch");
      emit(SkillError(e.toString()));
    }
  }

  void getDetailUser(int? idUser) async {
    emit(SkillLoading());
    try {
      final _data = await _userRepository.getUserDetail(id: idUser);
      _data.fold(
        (l) => emit(SkillError(l)),
        (r) => emit(UserDetailSuccess(r)),
      );
    } catch (e) {
      emit(SkillError(e.toString()));
    }
  }
}
