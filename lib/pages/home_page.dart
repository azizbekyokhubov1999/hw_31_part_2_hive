

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/result_model.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  String displayText = "";
  String displayList = "";
  List saved = [];
  int? num1, num2, result;
  void add(){
    setState(() {
      num1 = int.parse(controller1.text);
      num2 = int.parse(controller2.text);
      result = num1! + num2!;
    });
  }
  void sub(){
    setState(() {
      num1 = int.parse(controller1.text);
      num2 = int.parse(controller2.text);
      result = num1! - num2!;
    });
  }
  void div(){
    setState(() {
      num1 = int.parse(controller1.text);
      num2 = int.parse(controller2.text);
      result = num1! ~/ num2!;
    });
  }
  void mul(){
    setState(() {
      num1 = int.parse(controller1.text);
      num2 = int.parse(controller2.text);
      result = num1! * num2!;
    });
  }

  Future<void> save() async{
    final box = await Hive.openBox<ResultModel>('results');
    box.add(ResultModel(result!));
  }

  Future<void> printResults() async{
    final box1 = await Hive.openBox<ResultModel>('result');
    for (var result in box1.values) {
      displayText = 'Result: ${result.result}';
    }
    final box = await Hive.openBox<ResultModel>('results');
    for (var result in box.values) {
      displayList = 'Result: ${result.result}';
    }
  }
  Widget inputs(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          height: 60,
          child:  TextField(
            controller: controller1,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                hintText: 'Enter first number',
                hintStyle:  TextStyle(
                    color: Colors.black
                )
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          height: 60,
          child:  TextField(
            controller: controller2,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                hintText: 'Enter second number',
                hintStyle: TextStyle(
                    color: Colors.black
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget btnS(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            MaterialButton(
              onPressed: () async {
                add();
                controller1.clear();
                controller2.clear();
              },
              color: Colors.green,
              minWidth: 71,
              height: 30,
              child: const Text('+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 5),
            MaterialButton(
              onPressed: (){
                sub();
                controller1.clear();
                controller2.clear();
              },
              color: Colors.red,
              minWidth: 71,
              height: 30,
              child: const Text('-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
        Row(
          children: [
            MaterialButton(
              onPressed: (){
                mul();
                controller1.clear();
                controller2.clear();
              },
              color: Colors.yellow,
              minWidth: 71,
              height: 30,
              child: const Text('*',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 5),
            MaterialButton(
              onPressed: (){
                div();
                controller1.clear();
                controller2.clear();
              },
              color: Colors.deepPurple,
              minWidth: 71,
              height: 30,
              child: const Text('/',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            MaterialButton(
              onPressed: (){
                setState(() {
                  save();
                  printResults();
                  // saved. add(result);
                  // displayList = '$saved';
                });
              },
              color: Colors.blueAccent,
              minWidth: 149,
              height: 40,
              child: const Text('=',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blueAccent,
      //   title: const Text('Calculator'),
      // ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputs(),
              const SizedBox(height: 15),
              btnS(),
              const SizedBox(height: 15),
              Text(
                displayText,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                displayList,
                style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        )
    );
  }
}
