import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mercato_app/core/error/exceptions.dart';
import 'package:mercato_app/features/drugs/data/models/drug_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class DrugRemoteDataSource{
  Future<List<DrugModel>> getAllDrugs(String query);
  Future<Unit>updateDrugs(DrugModel drugModel);

}

 const BASE_URL ='https://dev.mercato-me.com/api/itemsApp/item';

  class DrugRemoteDataSourceImpl implements DrugRemoteDataSource{
    final http.Client client;
    final Uri uri = Uri.parse(BASE_URL);
    final Map<String, dynamic> queryParams = {};
    // final String query;

  DrugRemoteDataSourceImpl({required this.client,});


  @override
  Future<List<DrugModel>> getAllDrugs(query)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
      print("remotedatasource $query");

    final uriWithParams = uri.replace(queryParameters: {'key':query});

    final response = await client.get(uriWithParams,
    
    headers: {
      'Authorization':"Bearer $token"!
    }
    );
    print("respone : ${response.statusCode}");
    if(response.statusCode == 200){
      final List decodedJson = json.decode(response.body).values.first as List;

      final List<DrugModel> drugModels = decodedJson.map<DrugModel>((jsonDrugModel) => DrugModel.fromJson(jsonDrugModel)).toList();
      return drugModels;
    }else{
      throw ServerException();
    }

  }
  
  @override
  Future<Unit> updateDrugs(DrugModel drugModel)async {
    final drugId = drugModel;
    final body ={
      'name' : drugModel.name,
      'image':drugModel.image

    };

    final response = await client.patch(Uri.parse(BASE_URL),body: body);

    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }

  }

  }


