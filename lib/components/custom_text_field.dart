import 'package:flutter/material.dart';

class CustomNumberInput extends StatelessWidget {
  const CustomNumberInput({
    Key key,
    @required this.hintText,
    this.controller,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
