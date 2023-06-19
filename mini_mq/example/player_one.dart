import 'dart:async';

import 'package:mini_mq/mini_mq.dart';

class PlayerOne {
  PlayerOne() {
    _producer = MessageBroker().registerProducer('playerOneProducer');
    _consumer = MessageBroker().registerConsumer('playerOneConsumer');

    final StreamSubscription<Message> subscription =
        _consumer.subscribeToTopic('PlayerOneHp');

    subscription.onData((Message message) {
      print('Player One defending ${message.data}\n');
    });
  }

  late final Producer _producer;
  late final Consumer _consumer;

  void fireballAttack() {
    print('Player One attacking with fireball\n');
    _producer.sendMessage(
      topicKey: 'PlayerTwoHp',
      data: 'Fireball Attack',
    );
  }

  void swordAttack() {
    print('Player One attacking with sword\n');
    _producer.sendMessage(
      topicKey: 'PlayerTwoHp',
      data: 'Sword Attack',
    );
  }
}
