import 'dart:async';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/ui/user_dashboard/dashboard_card.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/drawer_bar.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreenUser extends StatefulWidget {
  @override
  _DashboardScreenUserState createState() => _DashboardScreenUserState();
}

class _DashboardScreenUserState extends State<DashboardScreenUser> {
  bool isLoading = true;
  int totalEmployee = 0;
  int totalEmployeeTask = 0;
  int totalAdminTask = 0;
  int allproject = 0;
  var dashboardModel;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  late List<LiveData> graphData;
  late ChartSeriesController _chartSeriesController;
  int time = 11;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), updateGraphData);
    super.initState();
    graphData = getGraphData();
    getDashboardData();
    getprojectData();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        header: "Employee Dashboard",
        leading: SideDrawer(),
        child: SafeArea(
          child: isLoading ? loadingAnimation() : SmartRefresher(
            onRefresh: () {
              getDashboardData();
            },
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.transparent,
                        ),
                        child: Column(children: [
                          const SizedBox(
                            height: 20,
                          ),
                          //SizedBox(height: size.height * .07),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DashboardCard(
                                  color: Colors.lightBlue,
                                  icon: Icons.note_add_outlined,
                                  label: 'Total Project',
                                  onPressed: () {},
                                  count: allproject.toString(),
                                ),
                                DashboardCard(
                                  color: Colors.green.shade900,
                                  icon: Icons.insights,
                                  count: totalAdminTask.toString(),
                                  label: 'My Task',
                                  onPressed: () {},
                                ),
                              ]),
                          SizedBox(height: size.height * .04),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DashboardCard(
                                  color: Colors.red.shade900,
                                  icon: Icons.account_box_rounded,
                                  label: 'Total Employee',
                                  count: totalEmployee.toString(),
                                  onPressed: () {},
                                ),
                                DashboardCard(
                                  color: Colors.yellow.shade900,
                                  icon: Icons.note_add_outlined,
                                  label: 'Total Employee Task',
                                  count: totalEmployeeTask.toString(),
                                  onPressed: () {},
                                ),
                              ]),
                          SizedBox(height: size.height * .04),
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
                                          'Performance Graph',
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20,)
                        ]),
                      ),
                    ],
                  ),
                )
            ),
          ),
        )
    );
  }
  getprojectData() async{
    var _fireStoreInastance=FirebaseFirestore.instance;
    QuerySnapshot qn = await FirebaseFirestore.instance.collection("Project_Type").get();
    setState(() {
      for(int i=0;i<qn.docs.length;i++){
        allproject=qn.docs.length;

      }
    });
    return qn.docs;
  }

  void getDashboardData () {
    try{
      final CollectionReference collectionReference1 = FirebaseFirestore.instance.collection('UserInfo');
      collectionReference1.get().then((value) {
        totalEmployee = value.size;
        final CollectionReference collectionReference2 = FirebaseFirestore.instance.collection('ExtraTaskInfo');
        collectionReference2.get().then((value) {
          totalEmployeeTask = value.size;

          final CollectionReference collectionReference3 = FirebaseFirestore.instance.collection('AdminTask');
          collectionReference3.get().then((value) {
            totalAdminTask = value.size;

            final CollectionReference userCollection = FirebaseFirestore.instance.collection('Project_Type');
            userCollection.get().then((value) {
              if(value.size > 0){
                value.docs.forEach((element) async {
                  dashboardModel = element.data();
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString('totalProject', allproject.toString());
                  sharedPreferences.setString('totalAdminTask', totalAdminTask.toString());
                  sharedPreferences.setString('totalEmployeeTask', totalEmployeeTask.toString());
                  sharedPreferences.setString('totalEmployee', totalEmployee.toString());

                  setState(() {
                    isLoading = false;
                    _refreshController.refreshCompleted();
                  });
                }
                );
              }
              else{
                setState(() {
                  isLoading = false;
                });
              }
            });
          });
        });
      });
    }
    catch(e){
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }


  List<LiveData> getGraphData() {
    return <LiveData> [
      LiveData(date: 1, value: 20),
      LiveData(date: 2, value: 15),
      LiveData(date: 3, value: 26),
      LiveData(date: 4, value: 33),
      LiveData(date: 5, value: 16),
      LiveData(date: 6, value: 18),
      LiveData(date: 7, value: 30),
      LiveData(date: 8, value: 27),
      LiveData(date: 9, value: 29),
      LiveData(date: 10, value: 11),
    ];
  }

  void updateGraphData(Timer timer) {
    graphData.add(LiveData(date: time++, value: math.Random().nextInt(50) + 10));
    graphData.removeAt(0);
    _chartSeriesController.updateDataSource(
      addedDataIndex: graphData.length - 1,
      removedDataIndex: 0,
    );
  }


  List<LineSeries<dynamic, int>> _getDefaultLineSeries() {
    return <LineSeries<dynamic, int>>[
      LineSeries<LiveData, int>(
        onRendererCreated: (ChartSeriesController controller) {
          _chartSeriesController = controller;
        },
        animationDuration: 1500,
        dataSource: graphData,
        xValueMapper: (LiveData data, _) => data.date,
        yValueMapper: (LiveData data, _) => data.value,
        width: 2,
        name: 'Task',
        //markerSettings: const MarkerSettings(isVisible: true)
      ),
    ];
  }

  SfCartesianChart performanceReportGraph() {
    return SfCartesianChart(
      plotAreaBorderWidth: 1,
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 0)
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}',
          interval: 1,
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)
      ),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}

class LiveData {
  int date;
  int value;

  LiveData({
    required this.date,
    required this.value,
  });

}

