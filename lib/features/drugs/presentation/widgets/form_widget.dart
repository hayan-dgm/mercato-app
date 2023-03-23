import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mercato_app/features/drugs/presentation/bloc/change/change_drugs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/image.dart';

class FormWidget extends StatefulWidget {
  final Images? img;
  late String id ;
   FormWidget({
    Key? key,
    this.img,required this.id
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late  String name= 'mercato_logo';
  late String uri= 'assets/mercato_logo.png';
  late String type = "jpg";
  final ImagePicker _picker = ImagePicker();

  void pickFromGallery ( )async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        name = image.name;
        uri = image.path;
        type =uri.split('. ')[1];
      });
    }
  }

  void pickFromCamera ( )async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        name = image.name;
        uri = image.path;
        type =uri.split('. ')[1];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(onPressed: (){pickFromGallery();}, child: FaIcon(FontAwesomeIcons.folderClosed)),
            TextButton(onPressed: (){pickFromCamera();}, child: FaIcon(FontAwesomeIcons.camera)),



            TextButton(
                onPressed: validateFormThenUpdateOrAddPost, child: Text("submit"),),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {


      final img = Images(id: widget.id, name:name , type: type, uri: uri);


        BlocProvider.of<ChangeDrugsBloc>(context)
            .add(UpdateDrugEvent(image: img));

    }
  }
