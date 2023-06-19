import 'dart:async';

import 'package:mini_mq/mini_mq.dart';

class PlayerTwo {
  PlayerTwo() {
    _producer = MessageBroker().registerProducer('playerTwoProducer');
    _consumer = MessageBroker().registerConsumer('playerTwoConsumer');

    final StreamSubscription<Message> subscription =
        _consumer.subscribeToTopic('PlayerTwoHp');

    subscription.onData((Message message) {
      print('Player Two defending ${message.data}\n');
    });
  }

  late final Producer _producer;
  late final Consumer _consumer;

  // void defendAttack() {}

  void snowStormAttack() {
    print('Player Two attacking with snowstorm\n');
    _producer.sendMessage(
      topicKey: 'PlayerOneHp',
      data: 'Snow Storm Attack',
    );
  }

  void mindControl() {
    print('Player Two attacking with mind control\n');
    _producer.sendMessage(
      topicKey: 'PlayerOneHp',
      data: 'Mind Control',
    );
  }
}
