class AdminTaskModel {
  String projectType;
  String taskCategory;
  String extraWorkName;
  String describeWork;
  String taskType;
  String status;
  String employeeEmail;
  String startTime;


  AdminTaskModel({
    required this.projectType,
    required this.taskCategory,
    required this.describeWork,
    required this.status,
    required this.startTime,
    required this.extraWorkName,
    required this.taskType,
    required this.employeeEmail,
  });
}
