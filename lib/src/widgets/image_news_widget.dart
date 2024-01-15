import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNewsWigget extends StatelessWidget {
  final String urlImage;
  final double height;
  final double width;

  const ImageNewsWigget(
      {super.key, required this.urlImage, this.height = 80, this.width = 80});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset('assets/no_image.png'),
        imageUrl: urlImage,
        height: height,
        width: width,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }
}

class Customer {
  // https://app.quicktype.io/#l=dart
  String Card;
  String Id;
  double Sum;

  Customer({required this.Card, required this.Id, required this.Sum});

  // @override
  // String toString() {
  //   return '{ ${this.Card}, ${this.Sum} }';
  // }

  factory Customer.fromMap(Map<dynamic, dynamic> json) =>
      new Customer(Card:json["Card"],Id:json["Id"],Sum:json["Sum"]);

  Map<String, dynamic> toMap() => {
        "Id": Id,
        "Card": Card,
        "Sum": Sum,
      };
}

Customer clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Customer.fromMap(jsonData);
}

String clientToJson(Customer data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
