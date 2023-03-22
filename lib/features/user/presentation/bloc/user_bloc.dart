import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mercato_app/core/error/exceptions.dart';
import 'package:mercato_app/core/network/network_info.dart';
import 'package:mercato_app/features/user/data/repositories/user_reposiotry_imp.dart';
import 'package:shared_preferences/shared_preferences.dart';



part 'user_event.dart';
part 'user_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepositoryImpliment repo;
  final NetworkInfo networkInfo;

  LoginBloc({required this.networkInfo, required this.repo}) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      if (event is StartEvent) {
        emit(LoginInitialState());

      } else if (event is SubmitLoginEvent) {
        if ( await networkInfo.isConnected ) {
          if(await networkInfo.isConnected == false){
            emit(LoginErrorState(message: "check your network connection"));
          }
          try {
            final data = await repo.login(event.email, event.password);
            if(event.email.isEmpty){
              throw EmptyFieldsException();
            }
            pref.setString('token', data['token']);
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            emit(LoginLoadingState());
            emit(LoginSuccessState());
          } on LoginException {
            emit(LoginErrorState(message: "wrong username or password"));
          }on EmptyFieldsException{
          emit(LoginErrorState(message: "one or more fields are empty"));
          }
        }


        }
      }

    );
  }
}




