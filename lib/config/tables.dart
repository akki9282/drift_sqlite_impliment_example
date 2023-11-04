import 'package:drift/drift.dart';

class Employee extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get emp_name => text()();
  TextColumn get department => text()();
}
