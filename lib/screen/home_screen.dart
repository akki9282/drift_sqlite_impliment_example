import 'package:drift_demo/config/database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/employee_controller.dart';
import 'employee_screen.dart';

class HomeScreen extends StatefulWidget {
  final EmployeeData? employeeData;
  final bool? isFormUpdate;
  const HomeScreen({super.key, this.employeeData, this.isFormUpdate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final sqlQuery = SQLQuery();
  var employeeTextController = TextEditingController();
  var departmentController = TextEditingController();

  @override
  void initState() {
    employeeTextController.text = widget.employeeData?.emp_name ?? '';
    departmentController.text = widget.employeeData?.department ?? '';
    super.initState();
  }

  EmployeeController employeeController = Get.put(EmployeeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Employee Details',
            style: TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 202, 199, 199)),
          ),
          backgroundColor: Color.fromARGB(255, 42, 52, 58)),
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Form(
          child: Container(
            margin: EdgeInsets.all(15),
            // padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                      controller: employeeTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Employee Name',
                        // labelText: 'Employee Name',
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                      controller: departmentController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Department',
                        // labelText: 'Employee Name',
                      )),
                ),
                // (widget.isFormUpdate ?? false)
                (widget.employeeData != null && widget.isFormUpdate == true)
                    ? ElevatedButton(
                        onPressed: () async {
                          if (employeeTextController.text.isNotEmpty &&
                              departmentController.text.isNotEmpty) {
                            await employeeController.updateEmployee(
                                EmployeeData(
                                    id: widget.employeeData?.id ?? 0,
                                    emp_name: employeeTextController.text,
                                    department: departmentController.text));

                            await employeeController.getEmployeeData();
                            employeeTextController.text = '';
                            departmentController.text = '';
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 42, 52, 58))),
                        child: Text('Update Details'),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (employeeTextController.text.isNotEmpty &&
                                  departmentController.text.isNotEmpty) {
                                await employeeController.addEmployeeDetails(
                                    employeeName: employeeTextController.text,
                                    department: departmentController.text);

                                employeeTextController.text = '';
                                departmentController.text = '';
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 42, 52, 58))),
                            child: Text('Add Emp. Details'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await employeeController.getEmployeeData();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => GetEmployee()));
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 42, 52, 58))),
                            child: Text('Get Emp. Details'),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
