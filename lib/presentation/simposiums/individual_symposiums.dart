import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/data/models/Simposium.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/parameter.dart';
import '../common/app_colors.dart';
import 'individual_symposium_widget.dart';

class IndividualSymposiumsScreen extends StatefulWidget {
  const IndividualSymposiumsScreen({Key? key, required this.parameter}) : super(key: key);
  final Parameter parameter;

  @override
  State<IndividualSymposiumsScreen> createState() => _IndividualSymposiumsScreenState();
}

class _IndividualSymposiumsScreenState extends State<IndividualSymposiumsScreen> {
  late Simposium simposium;

  Future<void> getSymposium(String id) async {
    simposium = await FirebaseApi.getSymposium(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            }),
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: getSymposium(widget.parameter.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          value: 50,
                        )));
              case ConnectionState.done:
                return IndividualSymposiumWidget(simposium: simposium);
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Result: ${snapshot.data}');
                }
            }
          }),
    );
  }
}
