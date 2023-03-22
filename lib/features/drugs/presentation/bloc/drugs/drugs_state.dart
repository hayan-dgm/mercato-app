part of 'drugs_bloc.dart';

abstract class DrugsState extends Equatable {
  const DrugsState();  

  @override
  List<Object> get props => [];
}
class DrugsInitial extends DrugsState {}

class LoadingDrugsState extends DrugsState{}



class LoadedDrugsState extends DrugsState{
  final List<Drug> drugs;

  LoadedDrugsState({required this.drugs});
    @override

  List<Object> get props => [drugs];

}



class ErrorDrugsState extends DrugsState{

  final String message;

  ErrorDrugsState({required this.message});

      @override
  List<Object> get props => [message];

}
