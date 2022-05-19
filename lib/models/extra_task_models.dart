class ExtraTaskModel {
  String projectType;
  String taskCategory;
  String extraWorkName;
  String describeWork;
  String taskType;
  String status;
  String employeeEmail;
  String startTime;
  String endTime;

  ExtraTaskModel({
    required this.projectType,
    required this.taskCategory,
    required this.describeWork,
    required this.status,
    required this.endTime,
    required this.startTime,
    required this.extraWorkName,
    required this.taskType,
    required this.employeeEmail,
  });
}
