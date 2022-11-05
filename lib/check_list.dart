import 'package:flutter/material.dart';

class CheckBoxState {
  final String title;
  bool value;

  CheckBoxState({
    required this.title,
    this.value = false,
  });
}

class CheckList extends StatefulWidget {
  // 1) создаем основной класс
  const CheckList({Key? key, required this.onSelected}) : super(key: key);
  final void Function(List<CheckBoxState> selectedFood)
      onSelected; //create function callback

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  final sortOfFood = [
    CheckBoxState(title: 'Сухой корм'),
    CheckBoxState(title: 'Влажный корм'),
    CheckBoxState(title: 'Натуральный корм'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      // 2)
      children: [
        ...sortOfFood
            .map(buildSingleCheckbox)
            .toList(), // 4) мар обходит все эл-ты коллекции ... = List.addAll()
      ],
    );
  }

  Widget buildSingleCheckbox(CheckBoxState item) => CheckboxListTile(
        // 3)  кобинация ListTile and Checkbox
        controlAffinity:
            ListTileControlAffinity.leading, // чтобы чекбоксы были слева
        value: item.value, // здесь присваивается
        title: Text(item.title),
        onChanged: (value) {
          setState(() => item.value = value!); //здесь меняется
          /// обойти коллекцию и каждый эл-т true вернуть в новый список list
          final list = sortOfFood.where((element) => element.value).toList();
          ///вызываем callback кот.передаст наши данные в место использ-я
          ///!для доступа к полям stfl виджета - использовать widget.
          widget.onSelected(list);
        },
      );
}
