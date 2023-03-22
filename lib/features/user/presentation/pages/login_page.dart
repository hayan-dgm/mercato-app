import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mercato_app/core/widgets/message_display_widget.dart';
import 'package:mercato_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();


  late LoginBloc loginBloc;

  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),

            child: Image.asset(
              'assets/mercato_logo.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height / 10,
              // alignment: Alignment.centerLeft,
            ),
          ),
          AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('ercato',
                  textStyle:
                      GoogleFonts.dangrek(fontSize: 50, color: Colors.white))
            ],
            repeatForever: true,
          )
        ],
      ),
    );
    final msg = BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginErrorState) {
            return MessageDisplayWidget(message: state.message);
          } else if (state is LoginLoadingState) {
            // _submitLogin();
            return Center(child:
            CircularProgressIndicator(),);
          } else {
            return Container();
          }
        }
    );
    final username = TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // helperText: "username",
        labelText: "E-Mail",

        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(15)),
          filled : true,
          fillColor: Color(0xFFe7edeb),
          hintText: "E-Mail",
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIconColor: Colors.blue[200],
          prefixIcon: Icon(Icons.mail),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
          )),

    );
    final pass = TextField(
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: InputDecoration(
          labelText: "Password",
          filled : true,
          fillColor: Color(0xFFe7edeb),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIconColor: Colors.blue[200],
          prefixIcon: Icon(Icons.password,),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(15)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
          )),
    );
    // final loginButton = Padding(
    //   padding: EdgeInsets.symmetric(vertical: 16.0),
    //   child: ElevatedButton(
    //     onPressed: () {
    //       loginBloc.add(SubmitLoginEvent(
    //           email: emailController.text, password: passwordController.text));
    //     },
    //     child: Text("Login"),
    //   ),
    // );

    void _submitLogin() {
      loginBloc.add(
          SubmitLoginEvent(
              // email: emailController.text,
              // password: passwordController.text
              email: "yasen@aspirin",
              password: "Test@123"

          ));
      Timer(Duration(seconds: 2), () {
        _btnController.error();
      });
    }
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(listener:
            (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushNamed(context, '/nav');
          }
        },
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery
                    .of(context)
                    .size
                    .height,
                maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width,),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue[800]!,
                  Colors.blue[600]!
                ], begin: Alignment.topLeft,
                    end: Alignment.centerRight
                ),

              ), child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Expanded(flex: 2, child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 36, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  logo,
                  SizedBox(height: 3,),
                ],
              ),
            )),
              Expanded(flex: 5,
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(200),
                            topRight: Radius.circular(0)
                        ),),
                    child: Padding(padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Login",style: GoogleFonts.mPlus1Code(fontSize: 40,color:Colors.blue[600])),
                          msg,
                          SizedBox(height: 10,),
                          username,
                          SizedBox(height: 20,),
                          pass,
                          SizedBox(height: 20,),
                          // loginButton
                          RoundedLoadingButton(
                            child: Text('Submit', style: TextStyle(color: Colors.white ,fontSize: 20)),
                            elevation: 25.0,
                            borderRadius: 80,
                            color: Colors.blue[600],
                            controller: _btnController,
                            resetAfterDuration: true,
                            onPressed: _submitLogin,
                          ),
                          TextButton(onPressed: ()async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            List<String> keys = prefs.getKeys().toList();
                            for (String key in keys) {
                              print('$key: ${prefs.get(key)}');
                            }
                          }, child: Text("Print cache")),
                          TextButton(onPressed: ()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.clear();}, child: Text("Delete cache")),
                            ],
                      ),

                    ),

                  ),
              )
                  ]),
            ),

          ),
        ),
      ),
    );
  }
}
