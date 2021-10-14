part of 'user_cubit.dart';

@immutable
abstract class SkillState {}

class SkillInitial extends SkillState {}

class SkillLoading extends SkillState {}

class SkillError extends SkillState {
  final String errorMessage;
  // ? call from consturctor
  SkillError(this.errorMessage);
}

class SkillGetSuccess extends SkillState {
  // ? The data type is string (adjusts the data type like the variable in the infrastructure "Future<String>")
  final UserList getData;
  SkillGetSuccess(this.getData);
}

class UserDetailSuccess extends SkillState {
  final UserDetailResponse getDetail;
  UserDetailSuccess(this.getDetail);
}
