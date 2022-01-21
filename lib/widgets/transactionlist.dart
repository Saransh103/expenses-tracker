import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transaction;
  final Function remove;

  var trailing;
  TransactionList(this._transaction, this.remove);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: _transaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No Transaction added',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: constrains.maxHeight * 0.05,
                  ),
                  Container(
                      height: constrains.maxHeight * 0.8,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  //1
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      //2
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            //3
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              //4
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  radius: 35,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                        color: Colors.purple,
                                        child: FittedBox(
                                          child: Text(
                                            '\$' +
                                                _transaction[index]
                                                    .amount
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _transaction[index].title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                    ),
                                    Text(
                                        DateFormat('yyyy-MM-dd')
                                            .format(_transaction[index].date),
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey))
                                  ],
                                ),
                              ],
                            )),
                        IconButton(
                            onPressed: () => remove(_transaction[index].id),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _transaction.length,
            ),
    );
  }
}
