import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
   const InputForm({
    required this.title, //какие данные виджет должен получать извне
    required this.error,
     this.keyboardType,
    Key? key,
  }) : super(key: key);

  final String title;
  final String error;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20.0),
        ),
        TextFormField(
          keyboardType: keyboardType,
          validator: (value) {
            if (value!.isEmpty) return error;
          },

        ),
      ],
    );
  }
}
