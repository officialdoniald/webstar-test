import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webstartest/services/models/driver_dto.dart';
import '../../language_constants.dart';

class DriverScreen extends StatelessWidget {
  Drivers model;
  BuildContext context;

  DriverScreen({
    super.key,
    required this.model,
    required this.context,
  });

  _back() {
    Navigator.pop(context);
  }

  _infoClicked() async {
    if (model.url == null) {
      return;
    }

    if (await canLaunchUrl(Uri.parse(model.url!))) {
      await launchUrl(Uri.parse(model.url!));
    }
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
          model.code ?? model.familyName ?? model.givenName ?? "-",
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          GestureDetector(
            onTap: _infoClicked,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset('assets/images/info.svg'),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${model.givenName!} ${model.familyName!}",
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "driver_nacionality"),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  " ${model.nationality}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "driver_birth"),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "${model.dateOfBirth}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "driver_permanentNumber"),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  model.permanentNumber ?? "-",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
