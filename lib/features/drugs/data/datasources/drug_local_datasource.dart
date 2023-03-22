import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mercato_app/core/error/exceptions.dart';
import 'package:mercato_app/features/drugs/data/models/drug_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DrugLocalDataSource{

  Future<List<DrugModel>> getCachedDrugs();
  Future<Unit>cacheDrugs (List<DrugModel> drugModels);
}

const CACHED_DRUGS ="CACHED_DRUGS";

class DrugLocalDataSourceImpl implements DrugLocalDataSource{

    final SharedPreferences sharedPreferences;
    DrugLocalDataSourceImpl({required this.sharedPreferences});


  @override 
  Future<Unit> cacheDrugs(List<DrugModel> drugModels) {
    List drugModelsToJson = drugModels.map<Map<String, dynamic>>((drugModel)=> drugModel.toJson()).toList();
     sharedPreferences.setString(CACHED_DRUGS, json.encode(drugModelsToJson));
     return Future.value(unit);
  }

  @override
  Future<List<DrugModel>> getCachedDrugs() {
    final jsonString = sharedPreferences.getString(CACHED_DRUGS);
    if(jsonString != null){
      List decodeJsonData = json.decode(jsonString);
      List<DrugModel>jsonToDrugModels = decodeJsonData.map<DrugModel>((jsonDrugModel) => DrugModel.fromJson(jsonDrugModel)).toList();
      return Future.value(jsonToDrugModels);
    }else{
      throw EmptyCacheException();
    }
  }
  
}