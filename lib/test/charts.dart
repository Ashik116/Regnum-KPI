// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:kpi_app/test/data.dart';
//
// class GrapPage extends StatefulWidget {
//   const GrapPage({Key? key}) : super(key: key);
//
//   @override
//   State<GrapPage> createState() => _GrapPageState();
// }
//
// class _GrapPageState extends State<GrapPage> {
//   late List<charts.Series<Data, String>> _seriesBarData;
//   late List<Data> myData;
//
//   _generateData(myData) {
//    _seriesBarData.add(
//      charts.Series(
//        domainFn:(Data ExtraTaskInfo,_)=>ExtraTaskInfo.status.toString(),
//        measureFn: (Data ExtraTaskInfo,_)=>ExtraTaskInfo.taskType.toString(),
//        colorFn: Colors.red;
//      )
//    );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
