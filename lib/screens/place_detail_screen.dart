import 'package:app/data/hero_tag.dart';
import 'package:app/model/location.dart';
import 'package:app/style/my_colors.dart';
import 'package:app/widgets/descriptions_location.dart';
import 'package:app/widgets/detailed_description_location.dart';
import 'package:app/widgets/hero_widget.dart';
import 'package:app/widgets/latitude_long.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  final Location location;
  final Animation animation;

  const PlaceDetailScreen({
    required this.location,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.mainBlue,
          title: const Text("Lugares", style: TextStyle(color: MyColors.white)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: Navigator.of(context).pop,
            ),
            const SizedBox(width: 10)
          ],
          leading: const Icon(
            Icons.location_on,
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox.expand(
                    child: HeroWidget(
                      tag: HeroTag.image(location.urlImage),
                      child: Image.asset(location.urlImage, fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: LatLongWidget(location: location),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            DetailedDescriptionLoc(location: location),
            Expanded(
              flex: 5,
              child:
                  DescriptionsWidget(location: location, animation: animation),
            ),
          ],
        ),
      );
}
