// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rail/Secrets.dart';

class TraininfoPage extends StatefulWidget {
  Map trainMetaData;
  String fromStation;
  String toStation;
  TraininfoPage(
      {super.key,
        required this.trainMetaData,
        required this.fromStation,
        required this.toStation});

  @override
  State<TraininfoPage> createState() => _TraininfoPageState();
}

class _TraininfoPageState extends State<TraininfoPage> {
  bool loading = true;
  Map trainSchedule = {};

  Future<void> getTrainSchedule() async {
    final queryParameters = {
      'trainNo': widget.trainMetaData["train_number"],
    };

    http.Response response = await http.get(
        Uri.https('irctc1.p.rapidapi.com', '/api/v1/getTrainSchedule',
            queryParameters),
        headers: {
          'X-RapidAPI-Key': API_KEY,
          'X-RapidAPI-Host': 'irctc1.p.rapidapi.com'
        });
    log(response.body);
    setState(() {
      trainSchedule = json.decode(response.body);
      loading = false;
    });
  }

  @override
  void initState() {
    getTrainSchedule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Train Info " + widget.trainMetaData["train_number"]),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(widget.trainMetaData["train_name"],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              Text(widget.trainMetaData["train_number"],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              Text(widget.trainMetaData["run_days"].join(", "),
                  style:
                  const TextStyle(color: Colors.white, fontSize: 22)),
              Text(
                  widget.trainMetaData["train_origin_station"] +
                      " (" +
                      widget.trainMetaData["train_origin_station_code"] +
                      ") to " +
                      widget.trainMetaData["train_destination_station"] +
                      " (" +
                      widget.trainMetaData[
                      "train_destination_station_code"] +
                      ")",
                  style:
                  const TextStyle(color: Colors.white, fontSize: 22)),
              Text(
                  widget.trainMetaData["depart_time"].substring(0, 5) +
                      " - " +
                      widget.trainMetaData["arrival_time"]
                          .substring(0, 5),
                  style:
                  const TextStyle(color: Colors.white, fontSize: 22)),
              Text(widget.trainMetaData["distance"] + " km",
                  style:
                  const TextStyle(color: Colors.white, fontSize: 22)),
              Text(widget.trainMetaData["class_type"].join(" | "),
                  style:
                  const TextStyle(color: Colors.white, fontSize: 22)),
              trainSchedule["data"] == null ||
                  trainSchedule["data"]["route"] == null
                  ? const Text(
                "Information Unavailable",
                style: TextStyle(color: Colors.white, fontSize: 22),
              )
                  : (trainSchedule["data"]["route"] as List).firstWhere(
                    (element) =>
                element["station_code"] ==
                    widget.fromStation,
                orElse: () => null,
              ) !=
                  null
                  ? Text(
                  "Platform at " +
                      widget.fromStation +
                      ": " +
                      (trainSchedule["data"]["route"] as List)
                          .firstWhere((element) =>
                      element["station_code"] ==
                          widget
                              .fromStation)["platform_number"]
                          .toString(),
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22))
                  : Text(
                  "From Station: " +
                      widget.fromStation +
                      " (Not in route)",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22)),
              trainSchedule["data"] == null ||
                  trainSchedule["data"]["route"] == null
                  ? const Text(
                "Information Unavailable",
                style: TextStyle(color: Colors.white, fontSize: 22),
              )
                  : (trainSchedule["data"]["route"] as List).firstWhere(
                    (element) =>
                element["station_code"] ==
                    widget.toStation,
                orElse: () => null,
              ) !=
                  null
                  ? Text(
                  "Platform at " +
                      widget.toStation +
                      ": " +
                      (trainSchedule["data"]["route"] as List)
                          .firstWhere((element) =>
                      element["station_code"] ==
                          widget.toStation)["platform_number"]
                          .toString(),
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22))
                  : Text(
                  "To Station: " +
                      widget.toStation +
                      " (Not in route)",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
