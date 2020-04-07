import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotelreservation/common/components/home_components/parallax_sliding_card.dart';

class StubData {
  static final StubData _singleton = StubData._internal();

  factory StubData() {
    return _singleton;
  }

  StubData._internal();

  List<String> get hotelCategories =>
      ["All", "Popular", "Top", "Sale", "30\$-100\$", "100\$-200\$"];

  List<HotelCard> get hotels => [
        HotelCard(
          title: "Hard Rock Hotel1",
          subTitle: "Central London",
          imageAsset: "assets/images/hotel_1.jpg",
        ),
        HotelCard(
          title: "Hard Rock Hotel2",
          subTitle: "Central London",
          imageAsset: "assets/images/hotel_2.jpg",
        ),
        HotelCard(
          title: "Hard Rock Hotel3",
          subTitle: "Central London",
          imageAsset: "assets/images/hotel_3.jpg",
        ),
        HotelCard(
          title: "Hard Rock Hotel4",
          subTitle: "Central London",
          imageAsset: "assets/images/hotel_4.jpg",
        ),
      ];

  List<EventCard> get events => [
        EventCard(
          title: "Ealing Blues Festival1",
          subTitle: "20 July",
          imageAsset: "assets/images/event_1.jpg",
        ),
        EventCard(
          title: "Ealing Blues Festival2",
          subTitle: "21 July",
          imageAsset: "assets/images/event_2.jpg",
        ),
        EventCard(
          title: "Ealing Blues Festival3",
          subTitle: "23 July",
          imageAsset: "assets/images/event_3.png",
        ),
        EventCard(
          title: "Ealing Blues Festival4",
          subTitle: "24 July",
          imageAsset: "assets/images/event_4.png",
        ),
      ];

  List<Widget> get facilities => [
        SvgPicture.asset(
          "assets/images/ic_room_service_6.svg",
          fit: BoxFit.none,
        ),
        SvgPicture.asset(
          "assets/images/ic_room_service_2.svg",
          fit: BoxFit.none,
        ),
        SvgPicture.asset(
          "assets/images/ic_room_service_1.svg",
          fit: BoxFit.none,
        ),
        SvgPicture.asset(
          "assets/images/ic_room_service_4.svg",
          fit: BoxFit.none,
        ),
        SvgPicture.asset(
          "assets/images/ic_room_service_3.svg",
          fit: BoxFit.none,
        ),
        SvgPicture.asset(
          "assets/images/ic_room_service_5.svg",
          fit: BoxFit.none,
        ),
      ];
}

class HotelCard implements ISlidingCard {
  final String title;
  final String subTitle;
  final String imageAsset;

  HotelCard({
    this.title,
    this.subTitle,
    this.imageAsset,
  });

  @override
  String cardTitle() => title;

  @override
  String cardSubTitle() => subTitle;

  @override
  String cardImageAsset() => imageAsset;
}

class EventCard implements ISlidingCard {
  final String title;
  final String subTitle;
  final String imageAsset;

  EventCard({
    this.title,
    this.subTitle,
    this.imageAsset,
  });

  @override
  String cardTitle() => title;

  @override
  String cardSubTitle() => subTitle;

  @override
  String cardImageAsset() => imageAsset;
}
