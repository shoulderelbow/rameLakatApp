import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

class AllDiseasesScreen extends StatelessWidget {
  const AllDiseasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: appbarWithBack(context)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _titleHeader(),
          searchTextField(),
          _allDiseasesContainer(),
        ],
      ),
    );
  }
}

Widget _titleHeader() => Container(
      height: 25.0,
      alignment: Alignment.center,
      child: Text(
        "Diseases",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );

final List listViewItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

Widget _allDiseasesContainer() => Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listViewItems.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              radius: 0,
              onTap: () {
                Navigator.of(context).pushNamed("/individual_disease");
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: ExactAssetImage("../../images/sampleDocImage4.png/"),
                        ),
                        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Doctor",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Cardiologist",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Luxembourg Ville - 2 km",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );


