import 'dart:async';

import 'package:mini_mq/mini_mq.dart';

class Topic {
  final StreamController<Message> _data = StreamController<Message>.broadcast();

  Stream<Message> get dataStream => _data.stream;

  void add(Message message) {
    _data.add(message);
  }
}
