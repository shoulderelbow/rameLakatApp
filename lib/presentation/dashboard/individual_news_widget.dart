import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/News.dart';
import 'dashboard_screen.dart';

class IndividualNewsWidget extends StatefulWidget {
  IndividualNewsWidget({required this.news});
  News news;
  @override
  State<IndividualNewsWidget> createState() => _IndividualNewsWidgetState();
}

class _IndividualNewsWidgetState extends State<IndividualNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                widget.news.name ?? "",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black54, spreadRadius: 2)],
              ),
              margin: EdgeInsets.all(20),
              child: Image.network(widget.news.pictureLocation ?? ""),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(Icons.date_range),
                  Text(widget.news.date.toString()),
                  SizedBox(width: 60),
                  Icon(Icons.source),
                  Text('IZVOR'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'OVDE STOJI PODNASLOV',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                  'OVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VESTOVDE SE PISE VEST'),
            ),
          ],
        ),
      ),
    );
  }
}
