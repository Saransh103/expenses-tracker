import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  get navigatator => null;

  get focusNode => null;

  get controller => null;

  void submitdata() {
    final enteredText = titleController.text;
    final enteredAmount = double.parse(
      amountController.text,
    );
    if (enteredAmount <= 0 || enteredText.isEmpty) {
      return;
    }
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        color: Colors.amber,
        child: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          width: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(3),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: Card(
                        elevation: 10,
                        child: TextFormField(
                          focusNode: focusNode,
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) => submitdata(),
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter Title',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: Card(
                        elevation: 10,
                        child: TextFormField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onFieldSubmitted: (_) => submitdata(),
                          controller: amountController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter Amount',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 4,
              ),
              Container(
                color: Colors.blue,
                child: MaterialButton(
                  height: 4,
                  elevation: 100,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.blue,
                    child: Text(
                      'Add Transaction',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () => submitdata(),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
