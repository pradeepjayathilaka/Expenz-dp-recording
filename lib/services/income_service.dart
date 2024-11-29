import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  //define the keyfor storing income in shared preferences
  static const String _incomeKey = 'income';

  //save the income to shared preferences
  Future<void> saveIncome(IncomeModel income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //Convert the existing income to List of IncomeModel object
      List<IncomeModel> existingIncomeObjects = [];

      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => IncomeModel.formJSON(json.decode(e)))
            .toList();
      }
      //add the new income to the list
      existingIncomeObjects.add(income);

      //Convert the List of IncomeModel objects back to a list of string
      List<String> updatedIncome =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      //save the updated list of income to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncome);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Income saved successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error on Adding Income!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<List<IncomeModel>> loadIncome() async {
    List<IncomeModel> loadedIncomes = [];
    try {
      // Retrieve the SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);
      debugPrint('Existing Incomes: $existingIncomes');
      // Convert the existing income to a list of IncomeModel objects
      if (existingIncomes != null) {
        loadedIncomes = existingIncomes
            .map((e) => IncomeModel.formJSON(json.decode(e)))
            .toList();
      }
    } catch (error) {
      // Log or handle the error
      debugPrint('Error loading incomes: $error');
    }

    // Return the loaded incomes (empty if an error occurred)
    return loadedIncomes;
  }

  //delete the income from shared preferences
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //Convert the existing income to List of IncomeModel object
      List<IncomeModel> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => IncomeModel.formJSON(json.decode(e)))
            .toList();
      }
      //remove the income with the given id from the list
      existingIncomeObjects.removeWhere((element) => element.id == id);

      //Convert the List of IncomeModel objects back to a list of string
      List<String> updatedIncomes =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      //save the updated list of income to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncomes);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Income deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error on Deleting Income!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
