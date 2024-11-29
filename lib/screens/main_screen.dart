import 'package:expenz/constants/colors.dart';
import 'package:expenz/models/expens_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transactions_screen.dart';
import 'package:expenz/services/expense_service.dart';
import 'package:expenz/services/income_service.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Expense> expenseList = [];
  List<IncomeModel> incomeList = [];

  //Function to fetch expences
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
      print(expenseList.length);
    });
  }

  //Function to fetch income
  void fetchAllIncome() async {
    List<IncomeModel> loadedIncome = await IncomeService().loadIncome();
    setState(() {
      incomeList = loadedIncome;
      print(incomeList.length);
    });
  }

//function to add  a new expense
  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpenses(newExpense, context);
    //Update the List of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  //function to add a new income
  void addNewIncome(IncomeModel newIncome) async {
    await IncomeService().saveIncome(newIncome, context);
    //Update the List of income
    setState(() {
      incomeList.add(newIncome);
    });
  }

  //function to remove an expense
  void removeExpense(Expense expense) {
    ExpenseService().deleteExpense(expense.id, context);
    //Update the List of expenses
    setState(() {
      expenseList.remove(expense);
    });
  }

  //function to remove an income
  void removeIncome(IncomeModel income) {
    IncomeService().deleteIncome(income.id, context);
    //Update the List of income
    setState(() {
      incomeList.remove(income);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncome();
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen List
    final List<Widget> pages = [
      const HomeScreen(),
      TransactionScreen(
        expenseList: expenseList,
        incomeList: incomeList,
        onDismissedExpenses: removeExpense,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      const BudgetScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: kGrey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'Budget',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
