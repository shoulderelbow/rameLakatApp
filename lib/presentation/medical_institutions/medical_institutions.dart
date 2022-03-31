import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

class MedicalInstitutions extends StatelessWidget {
  const MedicalInstitutions({Key? key}) : super(key: key);

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
  margin: EdgeInsets.only(left: 20),
  height: 25.0,
  alignment: Alignment.bottomLeft,
  child: const Text(
    "Medical institutions",
    style: TextStyle(
      fontSize: 20,
    ),
  ),
);

final List listViewItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

Widget _allDiseasesContainer() => Expanded(
  child: Container(
    decoration: const BoxDecoration(
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
            Navigator.of(context).pushNamed("/individual_institution");
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: true ? NetworkImage("https://static01.nyt.com/images/2020/04/07/science/31VIRUS-DOCTORDISSENT2/merlin_171128892_e2c150b8-7b4c-4ef1-bddd-2b2488a411b7-articleLarge.jpg?quality=75&auto=webp&disable=upscale") : ExactAssetImage("../../images/sampleDocImage4.png/") as ImageProvider,
                      //image: ExactAssetImage("../../images/sampleDocImage4.png/"),
                    ),
                    borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left:10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Name of the place",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Address",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Extra info",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize:
                              14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
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

