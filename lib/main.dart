import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontFamily: 'AkayaTelivigala', fontSize: 30),
              button: TextStyle(color: Colors.white),
            ),
        // appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.,
        fontFamily: 'OpenSans',

        // floatingActionButtonTheme: FloatingActionButtonThemeData(
        //  foregroundColor: Colors.red, backgroundColor: Colors.green),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int listIndex = 0;
  bool switchState = false;

  final List<Transaction> _userTransactionList = [
    // Transaction(
    //     id: DateTime.now().toString(),
    //     thing: 'gorceries',
    //     amount: 89,
    //     date: DateTime.now()),
    // Transaction(
    //     id: DateTime.now().toString(),
    //     thing: 'sport',
    //     amount: 120,
    //     date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactionList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txtSubject, double txtAmount, DateTime chosenDate) {
    final newTxt = Transaction(
      amount: txtAmount,
      thing: txtSubject,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactionList.add(newTxt);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  bool _showChart(bool val) {
    setState(() {
      switchState = val;
    });
    return switchState;
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactionList.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Chart'),
          Switch(value: switchState, onChanged: _showChart),
        ],
      ),
      switchState
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          // NewTransaction(_addNewTransaction),
          : txList,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txList) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txList
    ];
  }

  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    var appBar = AppBar(
      title: const Text('Expenses'),
      elevation: 30,

      shadowColor: Colors.orange,
      centerTitle: true,
      // backgroundColor: Colors.green,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        )
      ],
    );

    var txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactionList, _deleteTransaction),
    );

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (isLandscape)
                ..._buildLandscapeContent(mediaQuery, appBar, txList),
              if (!isLandscape)
                ..._buildPortraitContent(mediaQuery, appBar, txList),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        ));
  }
}
