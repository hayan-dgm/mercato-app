part of 'drugs_bloc.dart';

abstract class DrugsEvent extends Equatable {
  const DrugsEvent();

  @override
  List<Object> get props => [];
}


class GetAllDrugsEvent extends DrugsEvent{
  late String query;
   GetAllDrugsEvent({required this.query});
  @override
  List<Object> get props => [query];
}

class RefreshDrugsEvent extends DrugsEvent{

  final String query;
  const RefreshDrugsEvent({required this.query});
  @override
  List<Object> get props => [query];

}
