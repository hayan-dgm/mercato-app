
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mercato_app/core/network/network_info.dart';
import 'package:mercato_app/features/drugs/data/datasources/drug_local_datasource.dart';
import 'package:mercato_app/features/drugs/data/datasources/drug_remote_datasource.dart';
import 'package:mercato_app/features/drugs/data/repositories/drug_repository_imp.dart';
import 'package:mercato_app/features/drugs/domain/repositories/drugs_repository.dart';
import 'package:mercato_app/features/drugs/domain/usecases/get_all_drugs.dart';
import 'package:mercato_app/features/drugs/presentation/bloc/drugs/drugs_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

 GetIt sl = GetIt.instance;

Future<void> init()async{



//blocs
  sl.registerFactory(() => DrugsBloc(getAllDrugs: sl()));

  //usecases
  sl.registerLazySingleton(() => GetAllDrugsUseCase(sl()));

  //repos

  sl.registerLazySingleton<DrugsRepository>(() => DrugsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  
  //darasource
  
sl.registerLazySingleton<DrugRemoteDataSource>(() => DrugRemoteDataSourceImpl(client: sl()));
sl.registerLazySingleton<DrugLocalDataSource>(() => DrugLocalDataSourceImpl(sharedPreferences: sl()));

//core
sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));


//external
final sharedPreferences = await SharedPreferences.getInstance();
sl.registerLazySingleton(() => sharedPreferences);
sl.registerLazySingleton(() => http.Client());
sl.registerLazySingleton(() => InternetConnectionChecker());


}