import 'package:drift_demo/config/database.dart';

class SQLQuery {
  final database = AppDatabase();

  Future<List<EmployeeData>> getEmployee() async {
    return await database.select(database.employee).get();
  }

  addEmployee(
      {required String employeeName, required String department}) async {
    await database.into(database.employee).insert(EmployeeCompanion.insert(
        emp_name: employeeName, department: department));
  }

  Future<bool> updateEmployee(EmployeeData employeeData) async {
    return await database.update(database.employee).replace(employeeData);
  }

  deleteEmployee(int id) async {
    await (database.delete(database.employee)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
