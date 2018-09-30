import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/restaurant.dart';
import 'dart:async';

Size screenSize = new Size(0.0, 0.0);
bool searchMode; //Local Search: true, District Search: false

Map<String, double> currentLocation;
StreamSubscription<Map<String, double>> locationSubscription;

int pos = 0;
List<Restaurant> restaurantList = new List<Restaurant>();
List<int> history = new List<int>();
List<int> savedList = new List<int>();

TextStyle font36white = TextStyle(fontSize: 36.0, color: Colors.white);
TextStyle font26white = TextStyle(fontSize: 26.0, color: Colors.white);
TextStyle font18black = TextStyle(fontSize: 18.0, color: Colors.black);
TextStyle font18white = TextStyle(fontSize: 18.0, color: Colors.white);
TextStyle font14black = TextStyle(fontSize: 14.0, color: Colors.black);
TextStyle font14white = TextStyle(fontSize: 14.0, color: Colors.white);

List<String> chosenDistrictList = new List<String>();
List<String> districtList = ["Kwun_Tong", "Mei_Foo", "Mong_Kok", "Yau_Ma_Tei", "Yuen_Long", "Wan_Chai", "Hung_Hom", "Causeway_Bay", "Tai_Wo", "Prince_Edward", "Sheung_Shui", "North_Point", "Tai_Kok_Tsui", "Western_District", "Admiralty", "Fo_Tan", "Tai_Koo", "Tsim_Sha_Tsui", "Tsuen_Wan", "Aberdeen", "Cheung_Sha_Wan", "Tseung_Kwan_O", "Tuen_Mun", "Central", "Tung_Chung", "Sha_Tin", "Sheung_Wan", "Sham_Shui_Po", "Sai_Wan_Ho", "Tin_Hau", "Shau_Kei_Wan", "Ap_Lei_Chau", "Tin_Shui_Wai", "Wong_Tai_Sin", "Lok_Fu", "Lai_Chi_Kok", "Jordan", "Tai_Wai", "Wong_Chuk_Hang", "Heng_Fa_Chuen", "Lam_Tin", "Kwai_Fong", "Ngau_Tau_Kok", "Choi_Hung", "Quarry_Bay", "Tai_Hang", "Kwai_Chung", "Chai_Wan", "Kowloon_Tong", "Tai_Po", "Fanling", "Shek_Kip_Mei", "Yau_Tong", "San_Po_Kong", "Ho_Man_Tin", "Tsing_Yi", "Lantau_Island", "Kowloon_Bay", "Lok_Ma_Chau", "Pok_Fu_Lam", "Lo_Wu", "Stanley", "Mid-Levels", "Lamma_Island", "Tsz_Wan_Shan", "To_Kwa_Wan", "Sai_Kung", "Cheung_Chau", "Shek_O", "Deep_Water_Bay", "Happy_Valley", "Lau_Fau_shan", "Kowloon_City", "Sham_Tseng", "Po_Toi_Island", "Chek_Lap_Kok"];

void resetSuggestion(){
  pos = 0;
  restaurantList.clear();
  history.clear();
  savedList.clear();
}
