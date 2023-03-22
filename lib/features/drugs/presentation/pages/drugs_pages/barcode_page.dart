import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mercato_app/features/drugs/presentation/bloc/drugs/drugs_bloc.dart';
import 'package:mercato_app/features/drugs/presentation/pages/drugs_pages/details_page.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../domain/entities/drug.dart';

class BarcodePage extends StatefulWidget {
      BarcodePage({Key? key,}) : super(key: key);


     late List<Drug> drug= [];


  @override
  State<BarcodePage> createState() => _BarcodePageState();
}


class _BarcodePageState extends State<BarcodePage> {
  late DrugsBloc drugsBloc;
  List<Drug> detail = [];
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void initState() {
    drugsBloc =GetIt.I.get<DrugsBloc>();
    detail = List.from(widget.drug);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble()async {
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
    super.reassemble();
  }


  void updateListFromBarcode(String value) {
    setState(() {
      detail = widget.drug.where((element) => element.barcode!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrugsBloc, DrugsState>(
        builder: (context, state) {
          if(state is LoadedDrugsState && barcode != null && barcode!.code == state.drugs.first.barcode) {

            return DetailsPage(drug: state.drugs.first);
          }
      return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children:<Widget>[
            buildQrView(context),
            Positioned( bottom:10 ,child: buildResult(),)
          ],
        ),
      );}
    );


  }

  Widget buildResult() =>
      Container(decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(12),child: TextButton(onPressed: () {
          },
        child: Text(barcode !=null ? "Result:${barcode!.code}":"Scan a QR", maxLines: 3,))

  );
  Widget buildQrView(BuildContext context) => QRView(

        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
            borderLength: 20,
            borderRadius: 10,
            borderColor: Colors.blue[800]!,
            cutOutSize: MediaQuery.of(context).size.width *0.8),
      );

  void onQRViewCreated(QRViewController controller){
    setState(()=> this.controller = controller);
    controller.scannedDataStream.listen((barcode) {
       BlocProvider.of<DrugsBloc>(context).add(GetAllDrugsEvent(query:barcode.code!));
      setState((){
      this.barcode = barcode;
      });

    });
  }

}
