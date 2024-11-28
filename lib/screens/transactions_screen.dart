import 'package:expenz/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expens_model.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final void Function(Expense) onDismissedExpenses;
  const TransactionScreen({
    super.key,
    required this.expenseList,
    required this.onDismissedExpenses,
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
              height: MediaQuery.of(context).size.height * 0.35,
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
          ],
        ),
      )),
    );
  }
}
