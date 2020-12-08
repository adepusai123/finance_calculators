import 'package:finance_calulator/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {"id": "FD", "name": "Fixed Deposit"},
    {"id": "RD", "name": "Recurrence Deposit"},
    {"id": "DD", "name": "Daily Deposit"},
    {"id": "EMI", "name": "EMI"},
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Styles.bgColor,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text(
                    'Calculators',
                    style: TextStyle(
                      color: Styles.darkColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * .2,
                margin: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/svgs/Calculator.svg"),
              ),
              Container(
                height: size.height * .8,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    4,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalcBodyScreen(
                              name: items[index]['name'],
                              id: items[index]['id'],
                            ),
                          ),
                        );
                        // CompoundCalculation calc = new CompoundCalculation(
                        //   roi: 11.5,
                        //   months: 36,
                        //   principle: 15000,
                        //   cTimes: 4,
                        // );
                        // double m = calc.calcMaturity();
                        // RDCalculation rdc = new RDCalculation(
                        //   roi: 8,
                        //   months: 36,
                        //   principle: 2500,
                        //   cTimes: 12,
                        // );
                        // double m = rdc.calculate();
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/Rectangle.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            items[index]['name'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Styles.darkColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CalcBodyScreen extends StatelessWidget {
  const CalcBodyScreen({
    Key key,
    @required this.name,
    @required this.id,
  }) : super(key: key);

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Styles.darkColor,
        ),
        body: Container(
          color: Styles.bgColor,
          child: Center(
            child: Text(name),
          ),
        ),
      ),
    );
  }
}
