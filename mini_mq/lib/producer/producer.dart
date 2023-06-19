import 'package:mini_mq/mini_mq.dart';

class Producer {
  final String key;

  Producer(this.key, this._broker);

  final MessageBroker _broker;

  void sendMessage({
    required String topicKey,
    required String data,
  }) {
    _broker.sendMessage(
      topicKey,
      Message(key, data),
    );
  }
}
