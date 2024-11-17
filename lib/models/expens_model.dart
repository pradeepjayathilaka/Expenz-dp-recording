//enum for expense categories
import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  transport,
  health,
  shopping,
  subscription,
}

//category images
final Map<ExpenseCategory, String> expenceCategoryImages = {
  ExpenseCategory.food: 'assets/images/restaurant.png',
  ExpenseCategory.transport: 'assets/images/car.png',
  ExpenseCategory.health: 'assets/images/health.png',
  ExpenseCategory.shopping: 'assets/images/bag.png',
  ExpenseCategory.subscription: 'assets/images/bill.png',
};

//categories colors
final Map<ExpenseCategory, Color> expenseCategoryColors = {
  ExpenseCategory.food: const Color(0xFFE57373),
  ExpenseCategory.transport: const Color(0xff81c784),
  ExpenseCategory.health: const Color(0xFF64b5f6),
  ExpenseCategory.shopping: const Color(0xFFffd54f),
  ExpenseCategory.subscription: const Color(0xFF9575cd),
};

//model for expense
class Expense {
  final int id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.category,
      required this.date,
      required this.time,
      required this.description});

  //Convert the expense object to a json object(serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  //create an Expense object from a Json object
  factory Expense.formJSON(Map<String, dynamic> json) {
    return Expense(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        category: ExpenseCategory.values[json['category']],
        date: DateTime.parse(json['date']),
        time: DateTime.parse(json['time']),
        description: json['description']);
  }
}
