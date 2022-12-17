import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webstartest/services/models/driver_dto.dart';

import '../drivers/driver_screen.dart';

class FieldListViewItem extends StatelessWidget {
  Drivers model;
  BuildContext context;

  FieldListViewItem({
    super.key,
    required,
    required this.model,
    required this.context,
  });

  _infoClicked() async {
    if (model.url == null) {
      return;
    }

    if (await canLaunchUrl(Uri.parse(model.url!))) {
      await launchUrl(Uri.parse(model.url!));
    }
  }

  _navToFieldsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverScreen(driver: model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navToFieldsScreen,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  model.familyName ?? "-",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: _infoClicked,
              child: SvgPicture.asset('assets/images/info.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
