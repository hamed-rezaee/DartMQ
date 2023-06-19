import 'dart:async';

import 'package:mini_mq/mini_mq.dart';

class MessageBroker {
  static final MessageBroker _instance = MessageBroker._internal();

  factory MessageBroker() {
    return _instance;
  }

  MessageBroker._internal();

  /// Consumers and their subscriptions/
  final Map<Consumer, List<Topic>> _consumersAndTopics = {};

  /// Producers registered
  final Map<Producer, List<Topic>> _producersAndTopics = {};

  /// Topics registered
  final Map<String, Topic> _topics = {};

  /// Register a topic
  void registerTopic(String topicKey) {
    if (!_topics.containsKey(topicKey)) {
      _topics[topicKey] = Topic();
    }
  }

  void _setEmptyListenerList(Consumer consumer) =>
      _consumersAndTopics[consumer] = [];

  /// Register a consumer
  Consumer registerConsumer(String consumerKey) {
    /// If consumer is not registered, register it.
    if (!_consumersAndTopics.containsKey(consumerKey)) {
      final Consumer newConsumer = Consumer(consumerKey, this);

      _setEmptyListenerList(newConsumer);

      return newConsumer;
    }

    /// If consumer is registered, return it.
    return _consumersAndTopics.keys
        .where((Consumer consumer) => consumer.key == consumerKey)
        .first;
  }

  void _setEmptyProducerList(Producer producer) =>
      _producersAndTopics[producer] = [];

  /// Register a producer.
  Producer registerProducer(String producerKey) {
    /// If producer is not registered, register it.
    if (!_producersAndTopics.containsKey(producerKey)) {
      final Producer newProducer = Producer(producerKey, this);

      _setEmptyProducerList(newProducer);

      return newProducer;
    }

    /// If producer is registered, return it.
    return _producersAndTopics.keys
        .where((Producer producer) => producer.key == producerKey)
        .first;
  }

  /// Subscribe to a topic.
  StreamSubscription<Message> subscribeToTopic(
      Consumer consumer, String topicKey) {
    /// If topic is not registered, register it.
    if (!_topics.containsKey(topicKey)) {
      registerTopic(topicKey);
    }

    /// Fetch topic from broker.
    final Topic topic = _topics[topicKey]!;

    /// If consumer is not registered, register it.
    if (!_consumersAndTopics.containsKey(consumer)) {
      /// TODO - We should throw error
      /// MessageBroker.subscribeToTopic will only be called through a consumer
      /// that is registered.
    }

    /// If consumer is registered, subscribe to topic.
    _consumersAndTopics[consumer]!.add(topic);

    return topic.dataStream.listen((event) {});
  }

  /// Send a message to a topic.
  void sendMessage(String topicKey, Message message) {
    /// If topic is not registered, register it.
    if (!_topics.containsKey(topicKey)) {
      registerTopic(topicKey);
    }

    /// Fetch topic from broker.
    final Topic topic = _topics[topicKey]!;

    /// Add message to topic.
    topic.add(message);
  }
}
