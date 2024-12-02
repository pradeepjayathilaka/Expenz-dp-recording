import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expens_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/category_card.dart';
import 'package:expenz/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  const BudgetScreen({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedOption = 0;

  //methode to find the category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenseCategoryTotals
        : widget.incomeCategoryTotals;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Financial Report",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding / 2,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: kBlack.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedOption == 0 ? kRed : kWhite,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 59,
                          ),
                          child: Text(
                            "Expense",
                            style: TextStyle(
                              color: _selectedOption == 0 ? kWhite : kBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedOption == 1 ? kGreen : kWhite,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 59,
                          ),
                          child: Text(
                            "Income",
                            style: TextStyle(
                              color: _selectedOption == 1 ? kWhite : kBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            //pie chart
            Chart(
              expenseCategoryTotals: widget.expenseCategoryTotals,
              incomeCategoryTotals: widget.incomeCategoryTotals,
              isExpense: _selectedOption == 0,
            ),
            const SizedBox(
              height: 20,
            ),
            //list of categories
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final category = data.keys.toList()[index];
                  final total = data.values.toList()[index];
                  return CategoryCard(
                    title: category.name,
                    amount: total,
                    total:
                        data.values.reduce((value, element) => value + element),
                    progressColor: getCategoryColor(category),
                    isExpense: _selectedOption == 0,
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
