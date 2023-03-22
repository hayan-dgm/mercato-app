part of 'user_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends LoginEvent{}

class SubmitLoginEvent extends LoginEvent{
  final String email;
  final String password;
  SubmitLoginEvent({required this.email,required this.password});
}