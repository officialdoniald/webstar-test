import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:webstartest/services/base_api.dart';
import 'package:webstartest/services/models/driver_dto.dart';
import 'package:webstartest/services/models/season_dto.dart';

class SeasonAPI extends BaseApiProvider {
  Future<SeasonDTO?> getSeasons() async {
    //TODO: limit
    var responseString = await super.get('seasons.json?limit=74&offset=0');

    if (responseString == null) {
      return null;
    } else {
      return SeasonDTO.fromJson(jsonDecode(responseString));
    }
  }

  Future<DriverDTO?> getFields(String season) async {
    var responseString = await super.get('$season/drivers.json');

    if (responseString == null) {
      return null;
    } else {
      return DriverDTO.fromJson(jsonDecode(responseString));
    }
  }
}
