import 'package:flutter/material.dart';
import 'package:kpi_app/models/graph_model.dart';
import 'package:kpi_app/view/utils/background_admin.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PerformanceGraphScreen extends StatefulWidget {
  const PerformanceGraphScreen({Key? key}) : super(key: key);

  @override
  _PerformanceGraphScreenState createState() => _PerformanceGraphScreenState();
}

class _PerformanceGraphScreenState extends State<PerformanceGraphScreen> {
  List<GraphModel> graphData = <GraphModel>[];
  int totalTask = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    graphData = data!['graphData'];
    graphData.sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));


    for (GraphModel i in graphData) {
      totalTask = totalTask + i.value;
    }

    List<LineSeries<dynamic, num>> _getDefaultLineSeries() {
      return <LineSeries<dynamic, num>>[
        LineSeries<GraphModel, num>(
            animationDuration: 1500,
            dataSource: graphData,
            xValueMapper: (GraphModel sales, _) => DateTime.parse(sales.date).day,
            yValueMapper: (GraphModel sales, _) => sales.value,
            width: 2,
            name: 'Daily Task',
            markerSettings: const MarkerSettings(isVisible: true)
        ),
      ];
    }

    SfCartesianChart performanceReportGraph() {
      return SfCartesianChart(
        plotAreaBorderWidth: 1,
        primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          //majorGridLines: const MajorGridLines(width: 0)
        ),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            interval: 1,
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(color: Colors.transparent)),
        series: _getDefaultLineSeries(),
        tooltipBehavior: TooltipBehavior(enable: true),
      );
    }

    return BackgroundAdmin(
      header: 'Performance Graph',
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Total Task: $totalTask',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
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
                              'Employee Task Graph',
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
                        child: performanceReportGraph(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
