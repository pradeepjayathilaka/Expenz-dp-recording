import 'package:flutter/material.dart';

//income category enum
enum IncomeCategory {
  freelance,
  salary,
  passive,
  sales,
}

//category image
final Map<IncomeCategory, String> incomeCategoryString = {
  IncomeCategory.freelance: "assets/images/freelance.png",
  IncomeCategory.salary: "assets/images/car.png",
  IncomeCategory.passive: "assets/images/health.png",
  IncomeCategory.sales: "assets/images/salary.png",
};

//category colors
final Map<IncomeCategory, Color> incomeCategory = {
  IncomeCategory.freelance: const Color(0xFFE57373),
  IncomeCategory.salary: const Color(0xFF81c784),
  IncomeCategory.passive: const Color(0xFF64b5f6),
  IncomeCategory.sales: const Color(0xFFffd54f),
};

class IncomeModel {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });
}
