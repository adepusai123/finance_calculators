import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'screens/calc_body.dart';
import 'utils/styles.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {"id": "FD", "name": "Fixed Deposit"},
    {"id": "RD", "name": "Recurrence Deposit"},
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
                    items.length,
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
