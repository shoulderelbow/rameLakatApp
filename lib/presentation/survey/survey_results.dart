import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/presentation/common/app_colors.dart';

import '../common/common_views.dart';

class SurveyResults extends StatefulWidget {
  const SurveyResults({Key? key}) : super(key: key);

  @override
  State<SurveyResults> createState() => _SurveyResultsState();
}

class _SurveyResultsState extends State<SurveyResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: appbarWithBack(context)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 1, color: Colors.black54, spreadRadius: 1)],
                  ),
                  child: Image.network("https://www.nuvancehealth.org/-/media/images/services/infectious-disease-dr-female-clipboard-mask.jpg?h=282&iar=0&w=500&hash=BA2AD5C41CEADF3A42C009456279EDB5"),
                ),
                SizedBox(height: 20),
                Text("REZULTAT ANKETE", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),),
                SizedBox(height: 20),
                Text("OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI OPIS BOLESTI"),
                SizedBox(height: 20),
                Stack(children:[
                  Align(alignment: Alignment.centerLeft),
                  Text("PREPORUKA: ", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),)]),
              ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 580, left: 150),
                child: Container(
                  width: 300,
                  child: RaisedButton(color: Colors.white, onPressed: (){Navigator.of(context).pushNamed('/dashboard');}, child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Nazad na pocetnu stranu'),
                  ) ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
