import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_card.dart';
import 'package:flutter/material.dart';
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expens_model.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<IncomeModel> incomeList;
  final void Function(Expense) onDismissedExpenses;
  final void Function(IncomeModel) onDismissedIncome;
  const TransactionScreen({
    super.key,
    required this.expenseList,
    required this.onDismissedExpenses,
    required this.incomeList,
    required this.onDismissedIncome,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "See your financial report",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: kMainColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Expenses",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kBlack,
              ),
            ),
            const SizedBox(height: 20),
            //show all the expenses
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.expenseList.length,
                      itemBuilder: (context, index) {
                        final expense = widget.expenseList[index];
                        return Dismissible(
                          key: ValueKey(expense),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              widget.onDismissedExpenses(expense);
                            });
                          },
                          child: ExpenseCard(
                            title: expense.title,
                            date: expense.date,
                            amount: expense.amount,
                            category: expense.category,
                            description: expense.description,
                            time: expense.time,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),

            Text(
              "Incomes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kBlack,
              ),
            ),
            const SizedBox(height: 20),
            //show all the expenses
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.incomeList.length,
                      itemBuilder: (context, index) {
                        final income = widget.incomeList[index];
                        return Dismissible(
                          key: ValueKey(income),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              widget.onDismissedIncome(income);
                            });
                          },
                          child: IncomeCard(
                            title: income.title,
                            date: income.date,
                            amount: income.amount,
                            category: income.category,
                            description: income.description,
                            time: income.time,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
