// To parse this JSON data, do
//
//     final vitals = vitalsFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Vitals vitalsFromJson(String str) => Vitals.fromJson(json.decode(str));

String vitalsToJson(Vitals data) => json.encode(data.toJson());

class Vitals extends ChangeNotifier {
  Vitals({
    this.success,
    this.message,
    this.data,
  });

  bool success;
  String message;
  Data data;

  Future<void> getVitals()async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse('https://vital-signs-node.herokuapp.com/api/users/get'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      dynamic res = await response.stream.bytesToString();
      res = jsonDecode(res);
      data = Vitals.fromJson(res).data;
      notifyListeners();
      // getVitals();
    }
    else {
      print(response.reasonPhrase);
    }
  }

  factory Vitals.fromJson(Map<String, dynamic> json) => Vitals(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.senorsData,
  });

  List<SenorsDatum> senorsData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    senorsData: List<SenorsDatum>.from(json["senorsData"].map((x) => SenorsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "senorsData": List<dynamic>.from(senorsData.map((x) => x.toJson())),
  };
}

class SenorsDatum {
  SenorsDatum({
    this.id,
    this.userId,
    this.oxygenSaturation,
    this.heartRate,
    this.bodyTemperature,
    this.time,
    this.v,
    this.updatedAt,
  });

  String id;
  String userId;
  String oxygenSaturation;
  String heartRate;
  String bodyTemperature;
  DateTime time;
  int v;
  DateTime updatedAt;

  factory SenorsDatum.fromJson(Map<String, dynamic> json) => SenorsDatum(
    id: json["_id"],
    userId: json["userId"],
    oxygenSaturation: json["oxygenSaturation"],
    heartRate: json["heartRate"],
    bodyTemperature: json["bodyTemperature"],
    time: DateTime.parse(json["time"]),
    v: json["__v"],
    updatedAt: DateTime.parse(json["updated_At"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "oxygenSaturation": oxygenSaturation,
    "heartRate": heartRate,
    "bodyTemperature": bodyTemperature,
    "time": time.toIso8601String(),
    "__v": v,
    "updated_At": updatedAt.toIso8601String(),
  };
}
