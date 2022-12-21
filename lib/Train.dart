// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rail/TrainInfo.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

class TrainPage extends StatefulWidget {
  Map items;
  String fromStation;
  String toStation;
  TrainPage({
    super.key,
    required this.items,
    required this.fromStation,
    required this.toStation,
  });
  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trains from ${widget.fromStation} to ${widget.toStation}"),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.items["data"].length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                      widget.items["data"][index]["train_name"].length > 20
                          ? widget.items["data"][index]["train_name"]
                          .substring(0, 20) +
                          "..."
                          : widget.items["data"][index]["train_name"],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      widget.items["data"][index]["train_origin_station_code"] +
                          " - " +
                          widget.items["data"][index]
                          ["train_destination_station_code"] +
                          " | " +
                          widget.items["data"][index]["depart_time"]
                              .substring(0, 5) +
                          " - " +
                          widget.items["data"][index]["arrival_time"]
                              .substring(0, 5),
                      style:
                      const TextStyle(color: Colors.white, fontSize: 17)),
                  leading: Text(widget.items["data"][index]["train_number"],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  iconColor: Colors.white,
                  // collapsedIconColor: Colors.white,
                  // controlAffinity: ListTileControlAffinity.trailing,
                  // expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  // children: [
                  //   Text(widget.items["data"][index]["distance"] + " km",
                  //       style: const TextStyle(color: Colors.white)),
                  //   Text(
                  //       widget.items["data"][index]["run_days"]
                  //           .map((e) => e.substring(0, 2))
                  //           .join(", "),
                  //       style: const TextStyle(color: Colors.white)),
                  //   Text(widget.items["data"][index]["class_type"].join(", "),
                  //       style: const TextStyle(color: Colors.white)),
                  // ],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TraininfoPage(
                          trainMetaData: widget.items["data"][index],
                          fromStation: widget.fromStation,
                          toStation: widget.toStation,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Colors.white,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 Text(widget.items["data"][index]["train_name"],
//                     style: TextStyle(color: Colors.white)),
//                 Text(widget.items["data"][index]["train_number"],
//                     style: TextStyle(color: Colors.white)),
//                 Text(
//                     widget.items["data"][index]["train_origin_station_code"] +
//                         " - " +
//                         widget.items["data"][index]
//                             ["train_destination_station_code"],
//                     style: TextStyle(color: Colors.white)),
//                 Text(widget.items["data"][index]["depart_time"],
//                     style: TextStyle(color: Colors.white)),
//                 Text(widget.items["data"][index]["arrival_time"],
//                     style: TextStyle(color: Colors.white)),
//                 Text(widget.items["data"][index]["distance"] + " km",
//                     style: TextStyle(color: Colors.white)),
//               ],
//             ),
//           );
