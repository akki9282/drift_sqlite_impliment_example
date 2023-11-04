import 'package:drift_demo/config/sql_query.dart';
import 'package:get/get.dart';

import '../config/database.dart';

class EmployeeController extends GetxController {
  RxList<dynamic> employeeData = [].obs as RxList<dynamic>;

  addEmployeeDetails(
      {required String employeeName, required String department}) async {
    return await SQLQuery()
        .addEmployee(employeeName: employeeName, department: department);
  }

  getEmployeeData() async {
    employeeData.value = await SQLQuery().getEmployee();
  }

  updateEmployee(EmployeeData Data) async {
    await SQLQuery().updateEmployee(Data);
  }

  deleteEmployee(int id) async {
    await SQLQuery().deleteEmployee(id);
  }
}
