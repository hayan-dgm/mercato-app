import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercato_app/features/drugs/presentation/bloc/drugs/drugs_bloc.dart';
import 'package:mercato_app/navigation.dart';
// import 'features/drugs/presentation/pages/drugs_pages/search_page.dart';
import 'features/drugs/presentation/pages/drugs_pages/main_page.dart';
import 'features/user/data/repositories/user_reposiotry_imp.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/user/presentation/pages/login_page.dart';
import 'injection_container.dart'as di;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=> di.sl<DrugsBloc>()),
      BlocProvider(create: (context)=> LoginBloc( repo: UserRepositoryImpliment(), networkInfo: di.sl())),
      BlocProvider(create: (_)=> di.sl<DrugsBloc>()..add(GetAllDrugsEvent(query: ''))),


    ],

      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login' : (context)=>LoginPage(),
          '/nav':(context)=>NavigationPage(),
          // '/search page':(context)=>SearchPage(),
          '/try page':(context)=>MainPage()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
        ),
      ),
    );
  }
}

