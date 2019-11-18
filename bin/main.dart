import 'handler.dart';
import 'model.dart';
import 'worker.dart';


main(List<String> arguments) async {

  //Generic Implementation of Dart Isolates

  //Create instance of Worker

  var user = User(age: 29, name: 'Vijay');
  // Pipe contains the value that you want send and the sendPort.
  var pipeObj = Pipe<User>(value: user);
  Worker worker = Worker(pipe: pipeObj, executor: userIsolateHandler);

  // var person = Person(city: 'Hyderabad', country: 'India');
  // var pipeObj = Pipe<Person>(value: person);
  // Worker worker = Worker(pipe: pipeObj, executor: personIsolateHandler);

  // var pipeObj = Pipe<String>(value: 'Hello World');
  // Worker worker = Worker(pipe: pipeObj, executor: helloHandler);

  // var pipeObj = Pipe<int>(value: 50);
  // Worker worker = Worker(pipe: pipeObj, executor: numberHandler);


  // wait for the future to complete
  await worker.isReady;

  //get the message from worker and process
  if(worker.message is Pipe<Person>){
     print('My City is ${worker.message.value.city} and my Country is ${worker.message.value.country}.');
  }
  else if (worker.message is Pipe<User>){
    print('My Name is ${worker.message.value.name} and my age is ${worker.message.value.age}.');
  }
  else{
    print(worker.message.value);
  }

  worker.dispose();
 
}



