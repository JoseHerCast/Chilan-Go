import 'package:app/data/hero_tag.dart';
import 'package:app/data/locations.dart';
import 'package:app/model/location.dart';
import 'package:app/style/my_colors.dart';
import 'package:app/widgets/happy_level.dart';
import 'package:app/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class ExpandedContentLoc extends StatelessWidget {
  final Location location;

  const ExpandedContentLoc({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: MyColors.secondaryBlue,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HeroWidget(
              tag: HeroTag.addressLine1(location),
              child: Text(location.addressLine1,
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            const SizedBox(height: 8),
            buildAddressRating(location: location),
            const SizedBox(height: 12),
            buildReview(location: location)
          ],
        ),
      );

  Widget buildAddressRating({
    required Location location,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeroWidget(
            tag: HeroTag.addressLine2(location),
            child: Text(
              location.addressLine2,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          HeroWidget(
            tag: HeroTag.stars(location),
            child: HappyWidget(stars: location.starRating),
          ),
        ],
      );

  Widget buildReview({
    required Location location,
  }) =>
      Row(
        children: location.descriptions.map((description) {
          final pageIndex = locations.indexOf(location);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: HeroWidget(
              tag: HeroTag.avatar(description, pageIndex),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(description.urlImage),
              ),
            ),
          );
        }).toList(),
      );
}
