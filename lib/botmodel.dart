// To parse this JSON data, do
//
//     final botModel = botModelFromJson(jsonString);

import 'dart:convert';

BotModel botModelFromJson(String str) => BotModel.fromJson(json.decode(str));

String botModelToJson(BotModel data) => json.encode(data.toJson());

class BotModel {
  BotModel({
    this.cards,
    this.messages,
    this.status,
    this.suggested,
  });

  List<dynamic> cards;
  List<Message> messages;
  bool status;
  dynamic suggested;

  factory BotModel.fromJson(Map<String, dynamic> json) => BotModel(
    cards: List<dynamic>.from(json["cards"].map((x) => x)),
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    status: json["status"],
    suggested: json["suggested"],
  );

  Map<String, dynamic> toJson() => {
    "cards": List<dynamic>.from(cards.map((x) => x)),
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    "status": status,
    "suggested": suggested,
  };
}

class Message {
  Message({
    this.message,
    this.speech,
  });

  String message;
  String speech;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"],
    speech: json["speech"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "speech": speech,
  };
}
