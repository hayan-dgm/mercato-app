import 'package:mercato_app/features/drugs/domain/entities/drug.dart';

import '../../domain/entities/image.dart';

class ImageModel extends Images {
  ImageModel({
    required super.id,
    required super.uri,
    required super.name,
    required super.type
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['uri'],
        uri: json['uri'],
        name: json['name'],
             type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'uri': uri,
      'name': name,
      'type':type,
    };
  }
}
