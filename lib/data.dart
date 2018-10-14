import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/restaurant.dart';
import 'dart:async';

Size screenSize = new Size(0.0, 0.0);
int searchMode = 0; //District Search: 1, Local Search: 2
bool endSearch = false;

Map<String, double> currentLocation = new Map<String, double>();
StreamSubscription<Map<String, double>> locationSubscription;

int pos = -1;
List<Restaurant> restaurantList = new List<Restaurant>();
List<int> history = new List<int>();
List<int> savedList = new List<int>();

TextStyle font36white = TextStyle(fontSize: 36.0, color: Colors.white);
TextStyle font26white = TextStyle(fontSize: 26.0, color: Colors.white);
TextStyle font18black = TextStyle(fontSize: 18.0, color: Colors.black);
TextStyle font18white = TextStyle(fontSize: 18.0, color: Colors.white);
TextStyle font14black = TextStyle(fontSize: 14.0, color: Colors.black);
TextStyle font14white = TextStyle(fontSize: 14.0, color: Colors.white);
TextStyle font16black = TextStyle(fontSize: 16.0, color: Colors.black);

num distance = 0;
num maxDistance = 1500;
int maxDistanceFromMTR = 99;

Map<String, bool> beforeDistrictMap = new Map<String, bool>();
Map<String, bool> districtMap = {"Kwun Tong": false, "Mei Foo": false, "Mong Kok": false, "Yau Ma Tei": false, "Yuen Long": false, "Wan Chai": false, "Hung Hom": false, "Causeway Bay": false, "Tai Wo": false, "Prince Edward": false, "Sheung Shui": false, "North Point": false, "Tai Kok Tsui": false, "Western District": false, "Admiralty": false, "Fo Tan": false, "Tai Koo": false, "Tsim Sha Tsui": false, "Tsuen Wan": false, "Aberdeen": false, "Cheung Sha Wan": false, "Tseung Kwan O": false, "Tuen Mun": false, "Central": false, "Tung Chung": false, "Sha Tin": false, "Sheung Wan": false, "Sham Shui Po": false, "Sai Wan Ho": false, "Tin Hau": false, "Shau Kei Wan": false, "Ap Lei Chau": false, "Tin Shui Wai": false, "Wong Tai Sin": false, "Lok Fu": false, "Lai Chi Kok": false, "Jordan": false, "Tai Wai": false, "Wong Chuk Hang": false, "Heng Fa Chuen": false, "Lam Tin": false, "Kwai Fong": false, "Ngau Tau Kok": false, "Choi Hung": false, "Quarry Bay": false, "Tai Hang": false, "Kwai Chung": false, "Chai Wan": false, "Kowloon Tong": false, "Tai Po": false, "Fanling": false, "Shek Kip Mei": false, "Yau Tong": false, "San Po Kong": false, "Ho Man Tin": false, "Tsing Yi": false, "Lantau Island": false, "Kowloon Bay": false, "Lok Ma Chau": false, "Pok Fu Lam": false, "Lo Wu": false, "Stanley": false, "Mid-Levels": false, "Lamma Island": false, "Tsz Wan Shan": false, "To Kwa Wan": false, "Sai Kung": false, "Cheung Chau": false, "Shek O": false, "Deep Water Bay": false, "Happy Valley": false, "Lau Fau shan": false, "Kowloon City": false, "Sham Tseng": false, "Po Toi Island": false, "Chek Lap Kok": false};

List<String> districtList = ["Kwun Tong", "Mei Foo", "Mong Kok", "Yau Ma Tei", "Yuen Long", "Wan Chai", "Hung Hom", "Causeway Bay", "Tai Wo", "Prince Edward", "Sheung Shui", "North Point", "Tai Kok Tsui", "Western District", "Admiralty", "Fo Tan", "Tai Koo", "Tsim Sha Tsui", "Tsuen Wan", "Aberdeen", "Cheung Sha Wan", "Tseung Kwan O", "Tuen Mun", "Central", "Tung Chung", "Sha Tin", "Sheung Wan", "Sham Shui Po", "Sai Wan Ho", "Tin Hau", "Shau Kei Wan", "Ap Lei Chau", "Tin Shui Wai", "Wong Tai Sin", "Lok Fu", "Lai Chi Kok", "Jordan", "Tai Wai", "Wong Chuk Hang", "Heng Fa Chuen", "Lam Tin", "Kwai Fong", "Ngau Tau Kok", "Choi Hung", "Quarry Bay", "Tai Hang", "Kwai Chung", "Chai Wan", "Kowloon Tong", "Tai Po", "Fanling", "Shek Kip Mei", "Yau Tong", "San Po Kong", "Ho Man Tin", "Tsing Yi", "Lantau Island", "Kowloon Bay", "Lok Ma Chau", "Pok Fu Lam", "Lo Wu", "Stanley", "Mid-Levels", "Lamma Island", "Tsz Wan Shan", "To Kwa Wan", "Sai Kung", "Cheung Chau", "Shek O", "Deep Water Bay", "Happy Valley", "Lau Fau shan", "Kowloon City", "Sham Tseng", "Po Toi Island", "Chek Lap Kok"];
List<String> searchList = new List<String>.from(districtList);

void resetRestrictions(){
  maxDistance = 1500;
  maxDistanceFromMTR = 99;
}

