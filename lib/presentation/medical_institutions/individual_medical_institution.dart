import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/common_views.dart';

class IndividualMedicalInstitution extends StatelessWidget {
  const IndividualMedicalInstitution({Key? key}) : super(key: key);

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
          SafeArea(
            child: Row(
              children: [
                Container(
                  child: Image.network(
                      "https://www.dignityhealth.org/content/dignity-health/en/socal/locations/northridgehospital/_jcr_content/root/responsivegrid-body-layout/responsivegrid/cshhero_copy_copy/heroimage/desktop.coreimg.png/1635982797290/socal-nhmc-hospital-image-2.png"),
                  height: 150,
                  width: 150,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                ),
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "This is a name of a hospital",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "This is the location of a hospital",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "This is working time of a hospital",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
              color: AppColors.primaryDark,
              indent: 15,
              endIndent: 15,
              thickness: 1),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Description of the hospital - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "What it offers",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                      "Description of how to treat it - Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
