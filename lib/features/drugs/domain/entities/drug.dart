import 'package:equatable/equatable.dart';

class Drug extends Equatable{

  final String id ;
  final String name ;
  final int quantity ;
  final String image ;
  final String? barcode ;
  final int active ;
  final int available ;

  Drug({required this.id , required this.name ,required this.quantity, required this.image, required this.barcode, required this.active, required this.available});




  @override
  List<Object?> get props => [id,name,quantity,image,barcode,active,available];

}