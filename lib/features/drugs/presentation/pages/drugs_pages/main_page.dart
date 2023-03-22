import 'package:get_it/get_it.dart';
import 'package:mercato_app/core/widgets/loading_widget.dart';
import 'package:mercato_app/core/widgets/message_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercato_app/features/drugs/presentation/bloc/drugs/drugs_bloc.dart';
import 'package:mercato_app/features/drugs/presentation/pages/drugs_pages/display_page.dart';

import '../../../domain/entities/drug.dart';



class MainPage extends StatefulWidget {

  late List<Drug> drugs=[];
   MainPage({Key? key,}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  List<Drug>displayList=[];
  late DrugsBloc drugsBloc;
  late  String? refreshQueryParameter ;




  @override
  void initState() {
    drugsBloc =GetIt.I.get<DrugsBloc>();
    refreshQueryParameter ='';
    displayList = List.from(widget.drugs);
    super.initState();
  }




  void updateList(String value) {
    setState(() {
      displayList = widget.drugs.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  void updateListFromBarcode(String value) {
    setState(() {
      displayList = widget.drugs.where((element) => element.barcode!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return _buildBody();
            // body: _buildBody(),
    // );
  }


  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top:15,left: 15,right:15),
      child: Column(
        children: [
          // TextButton(onPressed: (){
          //   BlocProvider.of<DrugsBloc>(context).add(
          //       GetAllDrugsEvenet(query: "para"));
          // }, child: const Text("press")),
          TextField(
            onChanged:(value) {
              if (value.length >= 2) {
                refreshQueryParameter = '';
                BlocProvider.of<DrugsBloc>(context).add(
                    GetAllDrugsEvent(query: value));
                updateList(value);
              }else if (value.isEmpty){
                setState(() {
                  updateList('');
                });
              }

            },
    decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  hintText: "eg: paracetamol",
                  hintStyle: TextStyle(color: Colors.blue[300]),
                  labelText: "Search",
                  labelStyle: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                  // fillColor: Colors.blue[100],

                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Icon(Icons.search,color: Colors.blue[300],),
                  prefixIconColor: Colors.blueAccent,
                ),
          ),
          BlocBuilder<DrugsBloc, DrugsState>(
            builder: (context, state) {
              if (state is LoadingDrugsState) {
                return const LoadingWidget();
              }
              else if (state is LoadedDrugsState) {
                widget.drugs = state.drugs;
                return Expanded(
                  child: RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: DisplayPage(drugs: displayList,)),
                );
                // );
            }else if (state is ErrorDrugsState) {
                return MessageDisplayWidget(message: state.message);
              }
              return Container(width: 100 , height:100 ,padding: const EdgeInsets.all(50),color: Colors.red,);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<DrugsBloc>(context).add( RefreshDrugsEvent(query: refreshQueryParameter!));
  }
}
