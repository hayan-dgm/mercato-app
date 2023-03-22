import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:mercato_app/core/error/exceptions.dart';

const BASE_URL = "http://dev.mercato-me.com/api/itemsApp";


class UserRepositoryImpliment{

  // late  http.Client client;

  login(String email, String password)async{


    final response = await http.post(Uri.parse("http://dev.mercato-me.com/api/itemsApp/Login"),
    headers: {},
    body: {
      'email':email,
      'password':password

    }
    );


    if(response.statusCode==200){

    final data = json.decode(response.body);

    return data;

    }else{
      throw LoginException();
    }


  }
}

