import 'dart:async';

import 'package:mini_mq/mini_mq.dart';

class Consumer {
  final String key;
  final MessageBroker _broker;

  Consumer(this.key, this._broker);

  StreamSubscription<Message> subscribeToTopic(String topicKey) =>
      _broker.subscribeToTopic(this, topicKey);
}
