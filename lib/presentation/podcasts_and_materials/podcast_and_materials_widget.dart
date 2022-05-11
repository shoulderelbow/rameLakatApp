import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/app_assets.dart';
import '../common/app_colors.dart';
import '../common/app_strings.dart';
import 'all_podcasts_and_mateirals.dart';

class PodcastWidget extends StatefulWidget {
  PodcastWidget();

  @override
  State<PodcastWidget> createState() => _PodcastWidgetState();
}

class _PodcastWidgetState extends State<PodcastWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _titleHeader(),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 5,
              shadowColor: AppColors.primaryColorOp01,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: TextField(
                  autofocus: false,
                  style: TextStyle(color: AppColors.commonTextColor, fontSize: 18),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      contentPadding: const EdgeInsets.only(left: 5, bottom: 16, top: 16, right: 15),
                      hintStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.3)),
                      hintText: AppStrings.searchText),
                  onChanged: (String searchedText) {
                    filterPodcasts = [];
                    filterPostedMaterials = [];
                    for (int i = 0; i < podcasts.length; i++) {
                      if (podcasts[i].name?.contains(searchedText) ?? false) {
                        filterPodcasts.add(podcasts[i]);
                      }
                    }
                    for (int i=0; i<postedMaterials.length; i++) {
                      if (postedMaterials[i].name?.contains(searchedText) ?? false) {
                        filterPostedMaterials.add(postedMaterials[i]);
                      }
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: TabBar(
                  tabs: [
                    Tab(
                        child: Text(
                      "Podcast".tr(),
                      style: TextStyle(fontSize: 20),
                    )),
                    Tab(
                      child: (Text(
                        "Material".tr(),
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  ],
                )),
            Container(
              height: 300,
              width: 300,
              child: TabBarView(
                children: [
                  _allPodcastContainer(),
                  _allMaterialsContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _titleHeader() => Container(
      margin: EdgeInsets.only(left: 20),
      height: 25.0,
      alignment: Alignment.centerLeft,
      child: Text(
        "PodcastAndMaterial".tr(),
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

Widget _allPodcastContainer() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: filterPodcasts.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      child: AppAssets.podcastIconPng,
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          filterPodcasts[index].name ?? "",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                GestureDetector(
                  child: Text(filterPodcasts[index].link ?? '', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.blue)),
                  onTap: () async {
                    if (await canLaunchUrl(Uri.parse(filterPodcasts[index].link ?? ''))) {
                      await launchUrl(Uri.parse(
                        filterPodcasts[index].link ?? '',
                      ));
                    }
                  },
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
        );
      },
    );

Widget _allMaterialsContainer() => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: filterPostedMaterials.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: getIcon(index),
                  ),
                  SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        filterPostedMaterials[index].name ?? "",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              GestureDetector(
                child: Text(filterPostedMaterials[index].link ?? '', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.blue)),
                onTap: () async {
                  if (await canLaunchUrl(Uri.parse(filterPostedMaterials[index].link ?? ''))) {
                    await launchUrl(Uri.parse(
                      filterPostedMaterials[index].link ?? '',
                    ));
                  }
                },
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        );
      },
    );

getIcon(int index) {
  if (postedMaterials[index].type == 'literatura') {
    return AppAssets.bookIconPng;
  } else if (postedMaterials[index].type == 'video') {
    return AppAssets.videoIconPng;
  } else if (postedMaterials[index].type == 'muzika') {
    return AppAssets.musicIconPng;
  } else {
    return null;
  }
}
