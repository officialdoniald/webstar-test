import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webstartest/services/models/driver_dto.dart';
import '../../language_constants.dart';
import '../../main.dart';
import '../../services/season_api.dart';
import 'field_list_view_item.dart';

class FieldsScreen extends StatefulWidget {
  String? season;

  FieldsScreen({
    super.key,
    required this.season,
  });

  @override
  State<FieldsScreen> createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {
  late Future<DriverDTO?> fieldDTO;

  Future<DriverDTO?> _init() async {
    return getIt<SeasonAPI>().getFields(widget.season!);
  }

  _back() {
    Navigator.pop(context);
  }

  Column _drawDriverNationalityStatistic(List<Drivers> drivers) {
    var driversMap = groupBy(drivers.map((driver) => driver.toJson()).toList(),
        (Map obj) => obj['nationality']);

    driversMap = Map.fromEntries(driversMap.entries.toList()
      ..sort((e1, e2) => e2.value.length.compareTo(e1.value.length)));

    List<Widget> natList = [
      Text(
        getTranslated(context, "fields_screen_nationalities"),
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];

    driversMap.forEach(
      (nationality, list) {
        print('$nationality: ${list.length}');

        natList.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$nationality: ",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                list.length.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: natList,
    );
  }

  @override
  void initState() {
    super.initState();

    fieldDTO = _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: _back,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              "assets/images/back.svg",
            ),
          ),
        ),
        leadingWidth: 40,
        title: Text(
          widget.season!,
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      body: FutureBuilder<DriverDTO?>(
        future: fieldDTO,
        builder: (BuildContext context, AsyncSnapshot<DriverDTO?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null &&
                snapshot.data!.mRData != null &&
                snapshot.data!.mRData!.driverTable != null &&
                snapshot.data!.mRData!.driverTable!.drivers != null) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _drawDriverNationalityStatistic(
                        snapshot.data!.mRData!.driverTable!.drivers!),
                    ListView.builder(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          snapshot.data!.mRData!.driverTable!.drivers!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FieldListViewItem(
                          model: snapshot
                              .data!.mRData!.driverTable!.drivers![index],
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    getTranslated(context, 'seasons_screen_no_season_found'),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }
}
