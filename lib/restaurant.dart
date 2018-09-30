import 'package:eat_what_ho_v3/jsonLatLng.dart';

class Restaurant {
  final String name;
  final List<String> cuisine;
  final String price;
  final JsonLatLng latLng;
  final String rating;
  final List<String> reviews;
  final String district;
  final String url;
  final String address;
  final String mtr;
  final String pic;

  Restaurant(this.name, this.cuisine, this.price, this.latLng, this.rating, this.reviews, this.district, this.url, this.address, this.mtr, this.pic);

  Restaurant.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        cuisine = json['cuisine'].cast<String>(),
        price = json['price'],
        latLng = JsonLatLng.fromJson(json['location']),
        rating = json['rating'],
        reviews = json['reviews'].cast<String>(),
        district = json['district'],
        url = json['url'],
        address = json['address'],
        mtr = json['mtr'],
        pic = json['pic'];
}