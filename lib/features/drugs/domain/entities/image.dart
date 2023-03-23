import 'package:equatable/equatable.dart';

class Images extends Equatable{
  late String id;
  late String uri ;
  late String name ;
  late String type ;

   Images({required this.id,required this.uri, required this.name, required this.type});

  @override
  List<Object?> get props => [id,uri,name,type];

}