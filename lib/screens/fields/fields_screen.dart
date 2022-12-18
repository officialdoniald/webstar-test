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
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.mRData!.driverTable!.drivers!.length,
                itemBuilder: (BuildContext context, int index) {
                  return FieldListViewItem(
                    model: snapshot.data!.mRData!.driverTable!.drivers![index],
                    context: context,
                  );
                },
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
