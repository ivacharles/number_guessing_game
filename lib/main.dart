import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Random random = Random();
int min = 1;
int max = 10;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Iva\'s guessing game',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 3;
  bool _isButtonDisabled =false;
  int guessNumber = min + random.nextInt(max - min);

  void _resetGame(){
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) =>  const MyHomePage()
        )
    );
  }
  void _decrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      (_counter >0) ?_counter-- :_isButtonDisabled=true;
      print('----------------> $guessNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Welcome to my number guessing game', style: TextStyle(fontSize: 20 , color: Colors.black)),
      ),
      body:
          Column(
            children: [
               const Padding(
                 padding: EdgeInsets.all(18.0),
                 child: Text(' guess a number from one(1) to ten(10)', style: TextStyle(fontSize: 20 , color: Colors.black)),
               ),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 440,
                  child: GridView.count(
                      crossAxisCount: 3,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    children: List.generate(10, (index) {
                      return TextButton(
                        child: Text('$index', style: const TextStyle(fontSize: 30)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: const BorderSide(color: Colors.black)
                                )
                            )
                        ),
                        onPressed: () => {
                          (_isButtonDisabled) ? null : _decrementCounter(),
                          (guessNumber == index)
                              ? showDialog(
                              context: context,
                              builder: (_){
                                return AlertDialog(
                                  title: const Text('Congratulations!!', style: TextStyle(fontSize: 30)),
                                  actions: [
                                    CupertinoButton(
                                      child: const Text('ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              })
                              : print('loser')
                        }
                      );
                    }),
                  ),
                ),
              ),
               Column(
                 children: [
                   Padding(
                    padding: const EdgeInsets.all(0.0),
                      child: Text('you have $_counter guess(s) left', style: const TextStyle(fontSize: 20 , color: Colors.black87)),
                    ),
                    Center(  child: (_counter == 0) ? const Text('Game Over, try reset!', style: TextStyle(fontSize: 20 , color: Colors.black87)) : null )
                 ],
               ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetGame,
        child: const  Text('Reset', style: TextStyle(color: Colors.deepOrange),),
        backgroundColor: Colors.black,
        tooltip: 'Capture Picture',
        elevation: 5,
        splashColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,

      bottomNavigationBar: const BottomAppBar(
          color: Colors.deepOrange,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Design by Iva Lesperance Charles', textAlign: TextAlign.center , style: TextStyle(fontSize: 20 , color: Colors.black),
            ),
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
