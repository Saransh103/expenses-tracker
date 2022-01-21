import 'package:expenses_tracker/models/transaction.dart';
import 'package:expenses_tracker/widgets/transactionlist.dart';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "flutter app",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late String titleinput;
  bool hi = false;
  late String amountinput;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  late String dateinput;
  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  get children => null;

  void _addnew(String Txtitle, double Txamount) {
    bool island = MediaQuery.of(context).orientation == Orientation.landscape;
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: Txtitle,
        amount: Txamount,
        date: DateTime.now());
    super.setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startadding(BuildContext ctx) {
    MediaQuery.of(context).viewInsets.bottom;
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addnew),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _erase(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  bool switchans = false;
  @override
  Widget build(BuildContext context) {
    bool active = MediaQuery.of(context).orientation == Orientation.landscape;
    final option = Switch(

        //switch code is here
        value: switchans,
        onChanged: (val) {
          setState(() {
            switchans = val;
          });
        });
    final appbar = AppBar(
      title: Text('Expenses'),
      actions: [
        active
            ? (_userTransaction.length == 0
                ? IconButton(
                    onPressed: () => _startadding(context),
                    icon: Icon(Icons.app_registration_sharp))
                : option)
            : IconButton(
                onPressed: () => _startadding(context),
                icon: Icon(Icons.app_registration_sharp)),
      ],
    );
    final transactionlist = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            (active
                ? (_userTransaction.length != 0 ? (switchans ? 0.5 : 1) : 0.8)
                : (_userTransaction.length != 0 ? 0.7 : 0.9)),
        child: TransactionList(_userTransaction, _erase));
    final recenttransaction = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            (active
                ? (_userTransaction.length != 0 && switchans ? 0.5 : 0.28)
                : (_userTransaction.length != 0 ? 0.3 : 0.9)),
        child: Chart(_recentTransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          active
              ? (switchans
                  ? (Column(
                      children: [recenttransaction, transactionlist],
                    ))
                  : transactionlist)
              : (_userTransaction.length != 0
                  ? Column(
                      children: [recenttransaction, transactionlist],
                    )
                  : transactionlist)
        ]),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startadding(context),
      ),
    );
  }
}
