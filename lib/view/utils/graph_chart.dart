import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class EmployeeGraph extends StatefulWidget {
  const EmployeeGraph({Key? key}) : super(key: key);

  @override
  _EmployeeGraphState createState() => _EmployeeGraphState();
}

class _EmployeeGraphState extends State<EmployeeGraph> {
  final dailyReportLead = [
    DailyResultDataClass(DateTime(2021, 12, 1), 5),
    DailyResultDataClass(DateTime(2021, 12, 2), 25),
    DailyResultDataClass(DateTime(2021, 12, 3), 100),
    DailyResultDataClass(DateTime(2021, 12, 4), 75),
    DailyResultDataClass(DateTime(2021, 12, 5), 200),
    DailyResultDataClass(DateTime(2021, 12, 6), 475),
    DailyResultDataClass(DateTime(2021, 12, 7), 175),
    DailyResultDataClass(DateTime(2021, 12, 8), 775),
    DailyResultDataClass(DateTime(2021, 12, 9), 75),
    DailyResultDataClass(DateTime(2021, 12, 10), 550),
    DailyResultDataClass(DateTime(2021, 12, 11), 321),
    DailyResultDataClass(DateTime(2021, 12, 12), 425),
    DailyResultDataClass(DateTime(2021, 12, 13), 11),
    DailyResultDataClass(DateTime(2021, 12, 14), 195),
  ];

  late final List<charts.Series<dynamic, DateTime>> seriesList = [
    charts.Series<DailyResultDataClass, DateTime>(
      id: 'Lead',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (DailyResultDataClass daily, _) => daily.date,
      measureFn: (DailyResultDataClass daily, _) => daily.value,
      data: dailyReportLead,
    ),
  ];
  late final bool animate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //width: double.infinity,
              padding: const EdgeInsets.all(10),
              //height: 500,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      color: Colors.blue.shade800.withOpacity(0.2),
                      width: double.infinity,
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Monthly Employee Report',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      padding: EdgeInsets.all(10),
                      child: dailyReportGraph(seriesList),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
    ;
  }

  Widget dailyReportGraph(seriesList) {
    return charts.TimeSeriesChart(
      seriesList,
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true,
        stacked: true,
      ),
      animate: true,
    );
  }
}

class DailyResultDataClass {
  late final DateTime date;
  late final int value;

  DailyResultDataClass(this.date, this.value);
}
