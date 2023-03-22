import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mercato_app/features/drugs/domain/entities/drug.dart';
import 'package:mercato_app/features/drugs/presentation/pages/drugs_pages/details_page.dart';

class DisplayPage extends StatefulWidget {


  final  List<Drug> drugs;

  const DisplayPage({super.key, required this.drugs,});

  @override
  State<DisplayPage> createState() => _DisplayPageState();

}

class _DisplayPageState extends State<DisplayPage> {
  List<Drug>displayList=[];





@override
  void initState() {
  // BlocProvider.of<DrugsBloc>(context).add(
  //     GetAllDrugsEvenet(query: "para"));
  // drugsBloc =GetIt.I.get<DrugsBloc>();_____________
  displayList = List.from(widget.drugs);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.only(top:15,left: 15,right:15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: displayList.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors:[Colors.blue[100]!,Colors.lightBlueAccent[100]!,Colors.blue[100]!]),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(drug: displayList[index]))),
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Text(
                              displayList[index].name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(displayList[index].id),
                            trailing:
                            displayList[index].available ==1
                                ? Icon(
                              FontAwesomeIcons.circleCheck, color: Colors.green,)
                                : Icon(FontAwesomeIcons.circleXmark, color: Colors.red,),
                      leading: ClipRRect(borderRadius:BorderRadius.circular(10),
                        child: Image.network(fit: BoxFit.cover,width: 70,
                        "http://dev.mercato-me.com/assets/images/items/${displayList[index].image}",
                        errorBuilder: (context, error, stackTrace) {
                          if(error is NetworkImageLoadException || error != null ){
                            return ClipRRect(borderRadius:BorderRadius.circular(10),child: Image.asset('assets/mercato_logo.png',fit: BoxFit.cover,width: 70,));
                          }else{
                            return ClipRRect(borderRadius:BorderRadius.circular(10),child: Image.network("http://dev.mercato-me.com/assets/images/items/${displayList[index].image}",fit: BoxFit.cover,width: 70,));

                        }
                        }
                        ),
                      ),

                  ),
                    ),
                ),
              )
            ]),
      );
  }
}
