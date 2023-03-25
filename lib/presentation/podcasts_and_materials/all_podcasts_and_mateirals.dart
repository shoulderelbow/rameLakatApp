import 'package:flutter/material.dart';
import 'package:rame_lakat_app/data/models/PostedMaterial.dart';
import 'package:rame_lakat_app/presentation/podcasts_and_materials/podcast_and_materials_widget.dart';
import '../../bussines_logic/services/firebase/firebaseApi.dart';
import '../../data/models/Podcast.dart';
import '../common/app_colors.dart';
import '../common/common_views.dart';

List<Podcast> podcasts = [];
List<Podcast> filterPodcasts = [];

List<PostedMaterial> postedMaterials = [];
List<PostedMaterial> filterPostedMaterials = [];

class AllPodcastsScreen extends StatefulWidget {
  const AllPodcastsScreen();

  @override
  State<AllPodcastsScreen> createState() => _AllPodcastsState();
}

class _AllPodcastsState extends State<AllPodcastsScreen> {
  Future<void> getPodcastsAndMaterials() async {
    podcasts = await FirebaseApi.getPodcasts();
    filterPodcasts = await FirebaseApi.getPodcasts();

    postedMaterials = await FirebaseApi.getPostedMaterials();
    filterPostedMaterials = await FirebaseApi.getPostedMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(50), child: appbarWithBack(context)),
      body: FutureBuilder(
          future: getPodcastsAndMaterials(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                  value: 50,
                ));
              case ConnectionState.done:
                return PodcastWidget();
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


