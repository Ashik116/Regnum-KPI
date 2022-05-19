class Data {
  final String status;
  final String taskType;
  Data(this.status, this.taskType);
  Data.fromMap(Map<String, dynamic> map)
      : assert(map['status'] != null),
        assert(map['taskType'] != null),
        status = map['status'],
        taskType = map['taskType'];

  @override
  String toString() => "Record<$status:$taskType>";
}
