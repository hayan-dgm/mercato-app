import 'package:mercato_app/features/drugs/domain/entities/drug.dart';

class DrugModel extends Drug{
   DrugModel({required super.id, required super.name, required super.quantity, required super.image, required super.barcode, required super.active, required super.available});
  
  factory DrugModel.fromJson(Map<String,dynamic>json){
    return DrugModel(id: json['id'], name: json['name'], quantity: json['quantity'], image: json['image'], barcode: json['barcode'], active: json['active'], available: json['available']);

  }

  Map<String,dynamic>toJson(){
    return{

      'id':id,
      'name':name,
      'quantity':quantity,
      'image':image,
      'barcode':barcode,
      'active':active,
      'available':available

    };
  }
}