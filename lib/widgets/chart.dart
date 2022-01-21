import 'package:expenses_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> finaly;
  Chart(this.finaly);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0.0;
      for (int i = 0; i < finaly.length; i++) {
        if (finaly[i].date.day == weekday.day &&
            finaly[i].date.month == weekday.month &&
            finaly[i].date.year == weekday.year) {
          totalsum += finaly[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get MaxSpending {
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum + double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(10),
        child: Container(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValue.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: Chart_bars(
                    data['day'].toString(),
                    data['amount'] as double,
                    data['amount'] as double == 0
                        ? 0
                        : (data['amount'] as double) / MaxSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
