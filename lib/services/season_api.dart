import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:webstartest/services/base_api.dart';
import 'package:webstartest/services/models/season_dto.dart';

class SeasonAPI extends BaseApiProvider {
  Future<SeasonDTO?> getSeasons() async {
    var responseString = await super.get('seasons.json');

    if (responseString == null) {
      return null;
    } else {
      return SeasonDTO.fromJson(jsonDecode(responseString));
    }
  }
}
