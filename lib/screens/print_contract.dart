
import 'dart:io';
import 'package:crop_fit/utilities/printState.dart';
import 'package:flutter/cupertino.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';

import '../utilities/printState.dart';

class ContractPrintScreen extends StatefulWidget {
  const ContractPrintScreen({Key? key}) : super(key: key);

  @override
  State<ContractPrintScreen> createState() => _ContractPrintScreenState();
}

class _ContractPrintScreenState extends State<ContractPrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

 /* main() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: PrintState.page1,
        ),
      ),
    );
    //final file = File('contract.pdf');
    //await file.writeAsBytes(await pdf.save());
    await Printing.layoutPdf(onLayout: (_) => pdf.save());
  }

  @override
  void initState() {
    main();
    super.initState();
  }*/
}
