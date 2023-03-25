import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black54, spreadRadius: 2)],
              ),
              margin: EdgeInsets.all(20),
              child: Image.network(widget.news.pictureLocation ?? ""),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text("${widget.news.date?.day.toString()}.${widget.news.date?.month.toString()}.${widget.news.date?.year.toString()}", textAlign: TextAlign.left,),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.news.name ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Html(
                data: """${widget.news.newsText}""",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
