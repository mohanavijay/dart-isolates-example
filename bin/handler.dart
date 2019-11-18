import 'model.dart';

// TODO - Type checking is not handled for the callback function

void userIsolateHandler (Pipe stream) async {
  stream.value.age = 25;
  stream.value.name = 'John';
  stream.sendPort.send(stream);
}

void personIsolateHandler (Pipe stream) async {
  stream.value.country = 'India';
  stream.value.city = 'Delhi';
  stream.sendPort.send(stream);
}

void helloHandler (Pipe stream) async {

  String newVAl = stream.value.toUpperCase();
  stream.value = newVAl;
  stream.sendPort.send(stream);
}

void numberHandler (Pipe stream) async {

  int count = 2;
  for (int i = 0;  stream.value > i; i++){
    count = count * 2;
    print(count);
  }
  stream.value = count;
  // Its not necessary to send back the same object.
  // The send accepts dynamic parameter.
  // A different instace of object can be sent back.
  stream.sendPort.send(stream);
}