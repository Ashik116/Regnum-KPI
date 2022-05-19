import 'package:flutter/cupertino.dart';
import 'package:kpi_app/view/ui/admin/admin_assign_task_list.dart';
import 'package:kpi_app/view/ui/admin/admin_dashboard.dart';
import 'package:kpi_app/view/ui/admin/admin_task_edit.dart';
import 'package:kpi_app/view/ui/admin/assign_task.dart';
import 'package:kpi_app/view/ui/admin/dashboard_edit.dart';
import 'package:kpi_app/view/ui/admin/employee_details_admin.dart';
import 'package:kpi_app/view/ui/admin/employee_task_edit.dart';
import 'package:kpi_app/view/ui/admin/performance_graph.dart';
import 'package:kpi_app/view/ui/admin/single_employee_task_list.dart';
import 'package:kpi_app/view/ui/task/admin_task_list.dart';
import 'package:kpi_app/view/ui/task/task_details.dart';
import 'package:kpi_app/view/ui/auth/check_login.dart';
import 'package:kpi_app/view/ui/auth/login_screen.dart';
import 'package:kpi_app/view/ui/auth/singup_user.dart';
import 'package:kpi_app/view/ui/employee/employee_profile.dart';
import 'package:kpi_app/view/ui/employee/employee_profile_edit.dart';
import 'package:kpi_app/view/ui/task/extra_task_create.dart';
import 'package:kpi_app/view/ui/task/extra_task_list.dart';
import 'package:kpi_app/view/ui/task/task_edit_screen.dart';
import 'package:kpi_app/view/ui/employee/employee_list.dart';
import 'package:kpi_app/view/ui/user_dashboard/dashboard_user.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => CheckLogIn(),
  "/login": (BuildContext context) => LoginScreen(),
  "/signup/info": (BuildContext context) => SignupScreenUser(),
  "/dashboard/user": (BuildContext context) => DashboardScreenUser(),
  "/profile/user": (BuildContext context) => EmployeeProfileScreen(),
  "/extra/task/create": (BuildContext context) => CreateExtraTask(),
  "/dashboard/admin": (BuildContext context) => DashboardScreenAdmin(),
  "/employee/list": (BuildContext context) => EmployeeList(),
  "/employee/profile/update": (BuildContext context) => EmployeeProfileUpdate(),
  "/all/extra/task": (BuildContext context) => ExtraTaskList(),
  "/single/task/list": (BuildContext context) => SingleEmployeeTaskList(),
  "/task/details": (BuildContext context) => TaskDetailsScreen(),
  "/task/edit": (BuildContext context) => ExtraTaskEdit(),
  "/employee/details/admin": (BuildContext context) => EmployeeDetailsAdmin(),
  "/admin/dashboard/edit": (BuildContext context) => DashboardEdit(),
  "/admin/taskAssign": (BuildContext context) => AssignTask(),
  "/admin/taskList": (BuildContext context) => AdminTaskList(),
  "/admin/performanceGraph": (BuildContext context) => PerformanceGraphScreen(),
  "/admin/assignedTaskList": (BuildContext context) => AdminAssignTaskList(),
  "/admin/taskEdit": (BuildContext context) => AdminTaskEdit(),
  "/admin/employeeTaskEdit": (BuildContext context) => AdminEmployeeTaskEdit(),
};
