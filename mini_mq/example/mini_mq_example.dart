import 'dart:async';

import 'package:mini_mq/mini_mq.dart';

import 'player_one.dart';
import 'player_two.dart';

void main() async {
  MessageBroker().registerTopic('PlayerOneHp');
  MessageBroker().registerTopic('PlayerTwoHp');

  final PlayerOne playerOne = PlayerOne();

  final PlayerTwo playerTwo = PlayerTwo();

  await Future.delayed(Duration(seconds: 1));
  playerOne.fireballAttack();
  await Future.delayed(Duration(seconds: 1));
  playerTwo.snowStormAttack();
  await Future.delayed(Duration(seconds: 1));
  playerOne.swordAttack();
  await Future.delayed(Duration(seconds: 1));
  playerTwo.mindControl();
}
