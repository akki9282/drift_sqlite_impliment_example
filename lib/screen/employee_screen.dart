import 'package:drift_demo/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/employee_controller.dart';

class GetEmployee extends StatefulWidget {
  const GetEmployee({super.key});

  @override
  State<GetEmployee> createState() => _GetEmployeeState();
}

class _GetEmployeeState extends State<GetEmployee> {
  // Rx<List<EmployeeData>> employeeData = EmployeeController().employeeData;
  EmployeeController employeeController = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
          title: Text(
            'Get Employee Details',
            style: TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 202, 199, 199)),
          ),
          backgroundColor: Color.fromARGB(255, 42, 52, 58)),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Obx(
            () => DataTable(
              headingRowColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 110, 110, 110)),
              columnSpacing: 30,
              border: TableBorder.all(),
              columns: [
                DataColumn(
                    label: Text(
                  'ID',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 230, 220, 26)),
                )),
                DataColumn(
                    label: Text(
                  'Employee\nName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 230, 220, 26)),
                )),
                DataColumn(
                    label: Text(
                  'Department',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 230, 220, 26)),
                )),
                DataColumn(
                    label: Text(
                  'Delete/\nUpdate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color.fromARGB(255, 230, 220, 26)),
                )),
              ],
              rows:
                  // Obx(() => return )
                  List.generate(employeeController.employeeData.length,
                      (index) {
                return DataRow(cells: [
                  DataCell(Text(
                      employeeController.employeeData[index].id.toString())),
                  DataCell(
                      Text(employeeController.employeeData[index].emp_name)),
                  DataCell(
                      Text(employeeController.employeeData[index].department)),
                  DataCell(Expanded(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 42, 52, 58))),
                                content: Text('Are You Sure?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancle',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 42, 52, 58))),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await employeeController.deleteEmployee(
                                          employeeController
                                              .employeeData[index].id);
                                      await employeeController
                                          .getEmployeeData();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 42, 52, 58)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 186, 73, 63),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen(
                                          employeeData: employeeController
                                              .employeeData[index],
                                          isFormUpdate: true,
                                        )));
                          },
                          child: Icon(
                            Icons.change_circle_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )),
                ]);
              }),
            ),
          ),
        ),
      ),
    );
  }
}
