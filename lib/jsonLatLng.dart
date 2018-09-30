import 'package:latlong/latlong.dart';

class JsonLatLng{
  final LatLng latlng;

  JsonLatLng(this.latlng);

  JsonLatLng.fromJson(Map<String, dynamic> json)
    : latlng = new LatLng(json['latitude'], json['longitude']);
}