import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dogValueNotifier = DogValueNotifier(Dog.initial());
    final dogStateNotifier = DogStateNotifier(ImmutableDog.initial());

    return Scaffold(
      body: Center(
        child: StateNotifierBuilder<ImmutableDog>(
          stateNotifier: dogStateNotifier,
          builder: (context, dog, child) {
            return Text('${dog.age}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dogStateNotifier.birthday();
        },
      ),
    );
  }
}

// mutable way of handling state
class DogValueNotifier extends ValueNotifier<Dog> {
  DogValueNotifier(Dog dog) : super(dog);

  void birthday() {
    this.value.age++;
  }
}

class Dog {
  Dog(this.name, this.age);
  Dog.initial()
      : name = 'Spot',
        age = 12;

  String name;
  int age;
}

// immutable way of handling state
class DogStateNotifier extends StateNotifier<ImmutableDog> {
  DogStateNotifier(ImmutableDog dog) : super(dog);

  void birthday() {
    this.state = state.copyWith(age: state.age + 1);
  }
}

@immutable
class ImmutableDog {
  ImmutableDog({this.name, this.age});
  ImmutableDog.initial()
      : name = 'Spot',
        age = 12;

  final String name;
  final int age;

  ImmutableDog copyWith({
    String name,
    int age,
  }) {
    return ImmutableDog(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}
