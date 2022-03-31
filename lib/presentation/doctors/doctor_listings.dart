import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DoctorListingScreen extends StatelessWidget {
  const DoctorListingScreen({Key? key}) : super(key: key);

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
          _availableDoctorsContainer(),
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
    "Available Doctors",
    style: TextStyle(
      fontSize: 20,
    ),
  ),
);

final List listViewItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

Widget _availableDoctorsContainer() => Expanded(
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
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: true ? NetworkImage("https://epfamilydoctor.com/wp-content/uploads/2019/02/about.png") : ExactAssetImage("../../images/sampleDocImage4.png/") as ImageProvider,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Dr. X",
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
                          "Available Mon-Fri 9-15",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "+38169555555",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontWeight: FontWeight.w300,
                              fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RatingBarIndicator(
                          rating: 3.4,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: AppColors.ratingBarColor,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          unratedColor: Colors.black.withOpacity(0.2),
                          direction: Axis.horizontal,
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



