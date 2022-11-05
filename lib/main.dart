import 'package:flutter/material.dart';
import 'package:forms_7_week/check_list.dart';
import 'package:forms_7_week/input_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Pet form'),),
          body: Home(),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  Gender? _gender;
  final petFoodList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            const InputForm(
              title: 'Кличка питомца',
              error: 'Введие кличку питомца',
            ),
            const SizedBox(height: 20.0),
            const InputForm(
              title: 'Имя владельца',
              error: 'Введите имя владельца',
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Контактный E-mail:',
              style: TextStyle(fontSize: 20.0),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) return 'Пожалуйста введите свой E-mail';
                if (!value.contains('@')) return 'Это не E-mail';
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20.0),
            const InputForm(
              title: 'Порода питомца',
              error: 'Введите породу питомца',
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Пол питомца:',
              style: TextStyle(fontSize: 20.0),
            ),
            RadioListTile(
              title: const Text('Самец'),
              value: Gender.male,
              groupValue: _gender,
              onChanged: (Gender? value) {
                setState(() {
                  if (value != null) _gender = value;
                });
              },
            ),
            RadioListTile(
              title: const Text("Самка"),
              value: Gender.female,
              groupValue: _gender,
              onChanged: (Gender? value) {
                setState(() {
                  if (value != null) _gender = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Тип питания:',
              style: TextStyle(fontSize: 20.0),
            ),
            CheckList(
              onSelected: (List<CheckBoxState> selectedFood) {
                petFoodList.clear(); //чтобы лист был пустым перед каждым добавлением
                petFoodList.addAll(selectedFood);
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Color color = Colors.red;
                  String text;
                  if (_gender == null) {
                    text = 'Выберите пол животного';
                  } else if (petFoodList.isEmpty) {
                    text = 'Выберите тип питания';
                  } else {
                    text = 'Форма успешно заполнена';
                    color = Colors.green;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(text),
                      backgroundColor: color,
                    ),
                  );
                }
              },
              child: const Text('Проверить'),
            ),
          ],
        ),
      ),
    );
  }
}

enum Gender { male, female }
