import 'dart:async';
import 'dart:isolate';
import 'package:meta/meta.dart';
import 'model.dart';

typedef IsolateExecutor = void Function (Pipe pipeObj);

class Worker {

  Isolate _isolate;
  bool _paused = false;
  dynamic _message;
  ReceivePort _receiveport = ReceivePort();
  Capability _capability;
  Pipe pipe;
  IsolateExecutor executor;

  final _isReady = Completer<void>();

  Future<void> get isReady => _isReady.future;

  dynamic get message => _message;

  Worker({@required this.executor, @required this.pipe}) {
    this.pipe.sendPort = _receiveport.sendPort;
    init();
  }

  Future<void> init() async {
    _receiveport.listen(handleData);
    _isolate = await Isolate.spawn(executor, pipe);
  }

  void handleData(dynamic message) {
      _message = message;
      _isReady.complete();
  }

  void pause() {
    _paused ? _isolate.resume(_capability) : _capability = _isolate.pause();
  }

  void dispose() {
    _receiveport.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }
}
