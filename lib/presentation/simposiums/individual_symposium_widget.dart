import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rame_lakat_app/data/models/Simposium.dart';

class IndividualSymposiumWidget extends StatefulWidget {
  IndividualSymposiumWidget({required this.simposium});
  Simposium simposium;

  @override
  State<IndividualSymposiumWidget> createState() => _IndividualSymposiumWidgetState();
}

class _IndividualSymposiumWidgetState extends State<IndividualSymposiumWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black54, spreadRadius: 2)],
              ),
              margin: EdgeInsets.all(20),
              child: Image.network(widget.simposium.pictureLocation ?? ""),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20),
                  child: Text("${widget.simposium.date?.day.toString()}.${widget.simposium.date?.month.toString()}.${widget.simposium.date?.year.toString()}"),

            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.simposium.name ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Html(
                data: """${widget.simposium.symposiumText}""",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
