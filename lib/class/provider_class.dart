import 'package:flutter/material.dart';
import 'package:shift_calendar/class/salary_class.dart';

class SalaryProvider extends ChangeNotifier {
  List<Salary> _salaries = [];
  List<Salary> get salaries => _salaries;
  void addSalary(Salary salary) {
    _salaries.add(salary);
    notifyListeners();
  }
  void updateSalary(int index, Salary updatedSalary) {
    _salaries[index] = updatedSalary;
    notifyListeners();
  }
}