import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mercato_app/core/error/exceptions.dart';
import 'package:mercato_app/features/drugs/data/models/drug_model.dart';
import 'package:mercato_app/features/drugs/data/models/image_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
abstract class DrugRemoteDataSource{
  Future<List<DrugModel>> getAllDrugs(String query);
  Future<Unit>updateDrugs(ImageModel imageModel);

}

 const BASE_URL ='https://dev.mercato-me.com/api/itemsApp/item';

  class DrugRemoteDataSourceImpl implements DrugRemoteDataSource{
    final http.Client client;
    final Uri uri = Uri.parse(BASE_URL);
    final Map<String, dynamic> queryParams = {};

  DrugRemoteDataSourceImpl({required this.client,});


  @override
  Future<List<DrugModel>> getAllDrugs(query)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uriWithParams = uri.replace(queryParameters: {'key':query});

    final response = await client.get(uriWithParams,
    
    headers: {
      'Authorization':"Bearer $token"!
    }
    );
    if(response.statusCode == 200){
      final List decodedJson = json.decode(response.body).values.first as List;

      final List<DrugModel> drugModels = decodedJson.map<DrugModel>((jsonDrugModel) => DrugModel.fromJson(jsonDrugModel)).toList();
      return drugModels;
    }else{
      throw ServerException();
    }

  }



    @override
    Future<Unit> updateDrugs(ImageModel imageModel)async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://dev.mercato-me.com/api/itemsApp/item/${imageModel.id}'),
      );

      // Add headers to the request
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

        request.files.add(
          await http.MultipartFile.fromPath(
            "image",
            imageModel.uri,
            contentType: MediaType('image', imageModel.type),
          ),
        );
      // Send the request and wait for the response
      var response = await request.send();
      // Check the response status code
      if (response.statusCode == 200) {
        return Future.value(unit);

      } else {
        throw ServerException();
      }
    }




  }


