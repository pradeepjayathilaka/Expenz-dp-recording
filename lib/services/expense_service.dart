import 'dart:convert';

import 'package:expenz/models/expens_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //expence list
  List<Expense> expensesList = [];
  //define the key for storing expenses in shared preferences

  static const String EXPENSES_KEY = 'expenses';

  //save the expense to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? exisitngExpenses = prefs.getStringList(EXPENSES_KEY);

      //Covert the exisitng Expenses to List Expense object
      List<Expense> existingExpenseObjects = [];

      if (exisitngExpenses != null) {
        existingExpenseObjects = exisitngExpenses
            .map((e) => Expense.formJSON(json.decode(e)))
            .toList();
      }
      //Add the new expense to the List
      existingExpenseObjects.add(expense);

      //Convert the List of Expense objects back to a list of string
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();

      //save the updated list of expenses to shared preferences
      await prefs.setStringList(EXPENSES_KEY, updatedExpenses);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense saved successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error ona Adding Expense! '),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //loard the expences form shared preferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(EXPENSES_KEY);

    //Convert the existing expenses to a list of expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.formJSON(json.decode(e)))
          .toList();
    }
    return loadedExpenses;
  }
}
