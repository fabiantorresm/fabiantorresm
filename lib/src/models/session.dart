import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Session extends Equatable {
  final String token;
  final String client;
  final String uid;
  final int expiry;
  final DateTime createdAt;

  Session(
      {@required this.client,
      @required this.token,
      @required this.uid,
      @required this.expiry,
      @required this.createdAt});

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
        token: json['token'],
        client: json['client'],
        uid: json['uid'],
        expiry: json['expiry'],
        createdAt: DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      "token": this.token,
      "client": this.client,
      "uid": this.uid,
      "expiry": this.expiry,
      "createdAt": this.createdAt.toString(),
    };
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
