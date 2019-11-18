import 'dart:isolate';
import 'package:meta/meta.dart';

class Pipe <P> {
  P value;
  SendPort sendPort;
  
  Pipe({
    @required
    this.value,
    this.sendPort});
}

class User  {
 int age;
 String name;

  User({this.age, this.name});
}

class Person  {

  String city;
  String country;

  Person({this.city, this.country});

}