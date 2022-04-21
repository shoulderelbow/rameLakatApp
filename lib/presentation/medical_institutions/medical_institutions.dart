import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rame_lakat_app/bussines_logic/services/firebase/firebaseApi.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';
import 'package:rame_lakat_app/data/models/Institution.dart';


List<Institution> institutions = [];

class MedicalInstitutions extends StatefulWidget {
  const MedicalInstitutions({Key? key}) : super(key: key);

  @override
  State<MedicalInstitutions> createState() => _MedicalInstitutionsState();
}

class _MedicalInstitutionsState extends State<MedicalInstitutions> {

  void getInstitutions() async {
    institutions = await FirebaseApi.getInstitutions();
  }

  @override
  void initState() {
    getInstitutions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
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
  margin: EdgeInsets.only(left: 20),
  height: 25.0,
  alignment: Alignment.bottomLeft,
  child: Text(
    "Medical institutions".tr(),
    style: TextStyle(
      fontSize: 20,
    ),
  ),
);


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
      itemCount: institutions.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          radius: 0,
          onTap: () {
            Navigator.of(context).pushNamed("/individual_institution", arguments: {'id': institutions[index].uniqueId},);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: true ? NetworkImage("https://static01.nyt.com/images/2020/04/07/science/31VIRUS-DOCTORDISSENT2/merlin_171128892_e2c150b8-7b4c-4ef1-bddd-2b2488a411b7-articleLarge.jpg?quality=75&auto=webp&disable=upscale") : ExactAssetImage("../../images/sampleDocImage4.png/") as ImageProvider,
                      //image: ExactAssetImage("../../images/sampleDocImage4.png/"),
                    ),
                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left:10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          institutions[index].name ??  " ",
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
                          institutions[index].adress ?? ' ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          institutions[index].longDescription ?? " ",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize:
                              14),
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

