import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mercato_app/features/drugs/domain/entities/drug.dart';

class DetailsPage extends StatelessWidget {
   DetailsPage({Key? key, required this.drug}) : super(key: key);

 late Drug? drug;
  @override
  Widget build(BuildContext context) {
    return drug!=null?Scaffold(
      body:Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height *0.6,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("http://dev.mercato-me.com/assets/images/items/${drug!.image}"),fit: BoxFit.cover )
            ),
          ),Align(
            alignment: Alignment.bottomCenter,
                child: Container(
                height: MediaQuery.of(context).size.height *0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color:  Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                ),
                boxShadow: [BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, -4),
                  blurRadius: 8
                )]
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Edit",style: TextStyle(color: Colors.blue[800]),textAlign: TextAlign.center),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: () {},
                          child: FaIcon(FontAwesomeIcons.solidPenToSquare,size: 40,color: Colors.blue[800],)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left:30 ,right:30 ),
                    child: Row(
                      children: [

                        Expanded(
                          child: Text("${drug!.name}",
                          style: GoogleFonts.ptSans(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //     child: FaIcon(FontAwesomeIcons.penToSquare,size: 40,color: Colors.blue[800],))
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(
                    top: 30,
                    left: 30,
                    right: 30,
                  ),
                    child: Row(
                      children: [
                        Text("availability : ", style: GoogleFonts.ptSans(fontSize: 20,fontWeight: FontWeight.bold),),
                        drug!.available ==1 ? FaIcon(FontAwesomeIcons.circleCheck,color: Colors.green):FaIcon(FontAwesomeIcons.circleXmark, color: Colors.red ,),
                        SizedBox(width: 20,),
                        Text("activity : ", style: GoogleFonts.ptSans(fontSize: 20,fontWeight: FontWeight.bold),),
                        drug!.active ==1 ? FaIcon(FontAwesomeIcons.circleCheck,color: Colors.green):FaIcon(FontAwesomeIcons.circleXmark, color: Colors.red ,),

                      ],
                    ),
                  ),
                      Padding(
                        padding:  EdgeInsets.only(
                          top: 15,
                          left: MediaQuery.of(context).size.width*0.1,
                          right: 30,),
                        child: Container(padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.width*0.4,
                          decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(20)),
                          child: BarcodeWidget(
                              style: TextStyle(color: Colors.white),
                              data: drug!.barcode.toString(),
                              barcode: Barcode.code128(),
                              color: Colors.white,
                              width: double.infinity,
                              margin: EdgeInsets.all(10)),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text("id : ${drug!.id}",style: GoogleFonts.firaCode(fontSize: 10,height: 2,fontWeight: FontWeight.bold),),
                  )
                ],
                ),

              ),
          )
        ],
      )
    ):Container(child: Text("no data"),);
  }
}
