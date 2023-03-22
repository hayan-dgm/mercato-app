import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  const MessageDisplayWidget({Key? key, required this.message})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 20,
      child: Center(
          child: SingleChildScrollView(
        child: Text(
          message,
          style: TextStyle(fontSize: 15 ,color: Colors.red),
          textAlign: TextAlign.center,
        ),
      )),
    );
  }
}
