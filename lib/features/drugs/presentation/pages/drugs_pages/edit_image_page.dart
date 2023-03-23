import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercato_app/core/utils/snackbar_message_widget.dart';
import 'package:mercato_app/core/widgets/loading_widget.dart';
import 'package:mercato_app/features/drugs/presentation/bloc/change/change_drugs_bloc.dart';
import 'package:mercato_app/features/drugs/presentation/widgets/form_widget.dart';


class EditImagePage extends StatelessWidget {
    EditImagePage({Key? key ,required this.id}) : super(key: key);
   late String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: BlocConsumer<ChangeDrugsBloc,ChangeDrugsState>(
          listener: (context,state){
            if(state is MessageChangeDrugsState){
                SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
                // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MainPage()),);
            }
            else if(state is ErrorChangeDrugsState){
              SnackBarMessage().showErrorSnackBar(message: state.message, context: context);
            }
          },
          builder: (context, state) {

            if(state is LoadingChangeDrugsState){
              return const LoadingWidget();
            }
            return FormWidget(id :id );
          },

        )
      )
      ,
    );
  }
}
