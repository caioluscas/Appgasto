import 'dart:convert';

import 'package:app_gestao_de_custos/datetime/date_time_helper.dart';

import '../models/expense_item.dart';

class ExpenseData{
  //list all expenses
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
  List<ExpenseItem> getAllExpenseList(){
    return overallExpenseList;
  }

  //add new expense
  void addNewExpense(ExpenseItem expense){
    overallExpenseList.remove(expense);
  }
  //delete expense
  void deleteExpense(ExpenseItem expense){
    overallExpenseList.remove(expense);
  }

  //get weekday from a DateTime object
  String getDayName(DateTime dateTime){
    switch (dateTime.weekday){
      case 1:
        return 'Seg';
      case 2:
        return 'Ter';
      case 3:
        return 'Qua';
      case 4:
        return 'Qui';
      case 5:
        return 'SeX';
      case 5:
        return 'Sab';
      case 6:
        return 'Dom';
      default:
        return '';
    }
  }

  //get the date from the start of the week. 
  DateTime startOfWeekDate(){
    DateTime? startOfWeek;

    //get todays date
    DateTime today = DateTime.now();

    //go backwards from today 
    for(int i=0; i<7; i++){
      if(getDayName(today.subtract(Duration(days: i))) == 'Dom'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }


  //convert overall expenses list into a daily expense summary
  Map<String, double> calculateDailyExpenseSummary(){
    Map<String, double> dailyExpenseSummary = {

    };
    for(var expense in overallExpenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}