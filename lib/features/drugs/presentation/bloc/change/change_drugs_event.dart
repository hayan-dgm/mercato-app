part of 'change_drugs_bloc.dart';

// @immutable
abstract class ChangeDrugsEvent extends Equatable {

  @override
  List<Object>get props =>[];
}


class UpdateDrugEvent extends ChangeDrugsEvent{
  final Images image;

  UpdateDrugEvent({required this.image});

  @override
  List<Object>get props =>[image];

}
