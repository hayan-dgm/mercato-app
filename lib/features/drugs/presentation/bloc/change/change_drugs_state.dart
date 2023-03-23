part of 'change_drugs_bloc.dart';

// @immutable
abstract class ChangeDrugsState extends Equatable {
  const ChangeDrugsState();

  @override
  List<Object>get props =>[];
  }


class ChangeDrugsInitial extends ChangeDrugsState {}

class LoadingChangeDrugsState extends ChangeDrugsState{}


class ErrorChangeDrugsState extends ChangeDrugsState{
  final String message;

  ErrorChangeDrugsState({required this.message});

  @override
  List<Object>get props =>[message];

}


class MessageChangeDrugsState extends ChangeDrugsState{
  final String message;
  
    MessageChangeDrugsState({required this.message});

  @override
  List<Object>get props =>[message];}
