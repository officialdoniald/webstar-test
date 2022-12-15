class SeasonDTO {
  MRData? mRData;

  SeasonDTO({this.mRData});

  SeasonDTO.fromJson(Map<String, dynamic> json) {
    mRData =
        json['MRData'] != null ? new MRData.fromJson(json['MRData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mRData != null) {
      data['MRData'] = this.mRData!.toJson();
    }
    return data;
  }
}

class MRData {
  String? xmlns;
  String? series;
  String? url;
  String? limit;
  String? offset;
  String? total;
  SeasonTable? seasonTable;

  MRData(
      {this.xmlns,
      this.series,
      this.url,
      this.limit,
      this.offset,
      this.total,
      this.seasonTable});

  MRData.fromJson(Map<String, dynamic> json) {
    xmlns = json['xmlns'];
    series = json['series'];
    url = json['url'];
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    seasonTable = json['SeasonTable'] != null
        ? new SeasonTable.fromJson(json['SeasonTable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xmlns'] = this.xmlns;
    data['series'] = this.series;
    data['url'] = this.url;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['total'] = this.total;
    if (this.seasonTable != null) {
      data['SeasonTable'] = this.seasonTable!.toJson();
    }
    return data;
  }
}

class SeasonTable {
  List<Seasons>? seasons;

  SeasonTable({this.seasons});

  SeasonTable.fromJson(Map<String, dynamic> json) {
    if (json['Seasons'] != null) {
      seasons = <Seasons>[];
      json['Seasons'].forEach((v) {
        seasons!.add(new Seasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seasons != null) {
      data['Seasons'] = this.seasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Seasons {
  String? season;
  String? url;

  Seasons({this.season, this.url});

  Seasons.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['season'] = this.season;
    data['url'] = this.url;
    return data;
  }
}
