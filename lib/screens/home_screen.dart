import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expens_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/widgets/expense_card.dart';
import 'package:expenz/widgets/income_expense_card.dart';
import 'package:expenz/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<IncomeModel> incomeList;
  const HomeScreen({
    super.key,
    required this.expenseList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String username = "";
  double expenseTotal = 0;
  double incomeTotal = 0;
  @override
  void initState() {
    //get the username  form the shared preferences
    UserServices.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value['username']!;
        });
      }
    });
    setState(() {
      //total amount of expenses
      for (var i = 0; i < widget.expenseList.length; i++) {
        expenseTotal += widget.expenseList[i].amount;
      }
      //total amount of incomes
      for (var k = 0; k < widget.incomeList.length; k++) {
        incomeTotal += widget.incomeList[k].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            //main column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //bg color col
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.15),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: kMainColor,
                                border: Border.all(
                                  color: kMainColor,
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/images/user.jpg',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              "Welcome $username",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications,
                                color: kMainColor,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IncomeExpenseCard(
                                title: "Income",
                                amount: incomeTotal,
                                imageUrl: "assets/images/income.png",
                                bgcolor: kGreen),
                            IncomeExpenseCard(
                                title: "Expense",
                                amount: expenseTotal,
                                imageUrl: "assets/images/expense.png",
                                bgcolor: kRed),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //line chart
                const Padding(
                  padding: EdgeInsets.all(
                    kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Spend Frequency",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      LineChartSample(),
                    ],
                  ),
                ),
                //recent transactions
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "recent transactions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          widget.expenseList.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No expenses yet,add some expenses to hee here",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kGrey,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.expenseList.length,
                                  itemBuilder: (context, index) {
                                    final expense = widget.expenseList[index];
                                    return ExpenseCard(
                                      title: expense.title,
                                      date: expense.date,
                                      amount: expense.amount,
                                      category: expense.category,
                                      description: expense.description,
                                      time: expense.time,
                                    );
                                  },
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
