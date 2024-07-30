import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String noneText = '';
  String o = 'O';
  String x = 'X';
  String namePlayer1 = 'Player O';
  String namePlayer2 = 'Player X';
  int currentPlayer = 0;
  int countWinO = 0;
  int countWinX = 0;
  List<String> buttons = List<String>.generate(9, (index) => '');
  Color? colorCurrentPlayer = Colors.green[900];
  Color? colorNextPlayer = Colors.red[900];

  Color? _currentPlayer1() {
    if (currentPlayer % 2 != 0){
      return colorCurrentPlayer;
    }
    else {
      return colorNextPlayer;
    }
  }

  Color? _currentPlayer2() {
    if (currentPlayer % 2 == 0){
      return colorCurrentPlayer;
    }
    else {
      return colorNextPlayer;
    }
  }

  bool _checkWin() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (buttons[condition[0]] == x &&
          buttons[condition[1]] == x &&
          buttons[condition[2]] == x) {
        print('Player X Wins');
        return true;
      }
      if (buttons[condition[0]] == o &&
          buttons[condition[1]] == o &&
          buttons[condition[2]] == o) {
        print('Player O Wins');
        return true;
      }
    }
    return false;
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    namePlayer1,
                    style: TextStyle(fontSize: 18,
                        color: _currentPlayer1()),
                  ),
                  Text(
                    '$countWinO',
                    style: TextStyle(fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    namePlayer2,
                    style: TextStyle(fontSize: 18,
                        color: _currentPlayer2()),
                  ),
                  Text(
                    '$countWinX',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton(
          onPressed: () {
            setState(() {
              if (currentPlayer % 2 == 0) {
                print(currentPlayer);
                noneText = x;
                currentPlayer += 1;
              } else {
                print(currentPlayer);
                noneText = o;
                currentPlayer += 1;
              }
            });
          },
          child: Container(
            child: Text(
              noneText,
            ),
          ),
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 15),
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: GroupButton(
            buttons: buttons,
            onSelected: (buttonText, index, isSelected) => setState(() {
              if (_checkWin() == true) {
                return;
              }
              if (buttons[index] != '') return;
              if (currentPlayer % 2 == 0) {
                print('$currentPlayer ... $index ... $x ... $isSelected');
                buttons[index] = x;
                currentPlayer += 1;
              } else {
                print('$currentPlayer ... $index ... $o ... $isSelected');
                buttons[index] = o;
                currentPlayer += 1;
              }
              print(buttons);
              if (_checkWin() == true) {
                print('Game is Over');
                return;
              }
              if (currentPlayer == 9) {
                print('No One Wins');
                print('Game is Over');
                return;
              }
            }),
            isRadio: false,
            options: GroupButtonOptions(
              buttonHeight: 120,
              buttonWidth: 120,
              //Color: Colors.grey[300], // Цвет кнопок по умолчанию
              selectedColor: Colors.deepPurple[300], // Цвет кнопок при нажатии
              selectedTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.pink[900],
              ),
              unselectedColor: Colors.deepPurple[300],
              unselectedTextStyle: TextStyle(
                fontSize: 20,
                color: Colors.pink[900],
              ),
              //border: Colors.black, // Цвет границы кнопок
              borderRadius: BorderRadius.circular(10),
              //mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
