import 'package:expenz/constants/colors.dart';
import 'package:expenz/constants/constants.dart';
import 'package:expenz/models/expens_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/widgets/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  // State to track expense and income categories and toggle selection
  int _selectedMethode = 0;
  ExpenseCategory _expenseCategory = ExpenseCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethode == 0 ? kRed : kGreen,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _selectedMethode = 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedMethode == 0 ? kRed : kWhite,
                            border: Border.all(
                              color: _selectedMethode == 0
                                  ? const Color.fromARGB(255, 17, 16, 16)
                                  : kWhite,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 55,
                              vertical: 8,
                            ),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: _selectedMethode == 0 ? kWhite : kBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _selectedMethode = 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedMethode == 1 ? kGreen : kWhite,
                            border: Border.all(
                              color: _selectedMethode == 1
                                  ? const Color.fromARGB(255, 17, 16, 16)
                                  : kWhite,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 55,
                              vertical: 8,
                            ),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: _selectedMethode == 1 ? kWhite : kBlack,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How Much?",
                        style: TextStyle(
                          color: kLightGrey.withOpacity(0.8),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextField(
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: kWhite,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3,
                ),
                decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Form(
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          value: _selectedMethode == 0
                              ? _expenseCategory
                              : _incomeCategory,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding, horizontal: 20),
                          ),
                          items: _selectedMethode == 0
                              ? ExpenseCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList()
                              : IncomeCategory.values.map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (_selectedMethode == 0 &&
                                  value is ExpenseCategory) {
                                _expenseCategory = value;
                              } else if (_selectedMethode == 1 &&
                                  value is IncomeCategory) {
                                _incomeCategory = value;
                              }
                              print(_selectedMethode == 0
                                  ? _expenseCategory.name
                                  : _incomeCategory.name);
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        //title field
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding, horizontal: 20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //description fileld
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding, horizontal: 20),
                          ),
                        ),
                        const SizedBox(height: 20),
                        //amount field
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: 20,
                            ),
                          ),
                        ),
                        //date picker
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2025),
                                ).then(
                                  (value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                    }
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: kMainColor,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        color: kWhite,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ), //TextStyle
                                      ), //Text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(_selectedDate),
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        //date picker
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedTime = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                        value.hour,
                                        value.minute,
                                      );
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: kYellow,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: kWhite,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Select Time",
                                        style: TextStyle(
                                          color: kWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ), //TextStyle
                                      ), //Text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.jm().format(_selectedTime),
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: kLightGrey,
                          thickness: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomeButton(
                            buttonName: "Add",
                            buttonColor: _selectedMethode == 0 ? kRed : kGreen)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
