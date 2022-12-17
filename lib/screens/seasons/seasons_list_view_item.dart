import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webstartest/screens/fields/fields_screen.dart';
import '../../services/models/season_dto.dart';

class SeasonsListViewItem extends StatelessWidget {
  Seasons model;
  BuildContext context;

  SeasonsListViewItem({
    super.key,
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
        builder: (context) => FieldsScreen(season: model.season),
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
            Text(
              model.season ?? "-",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
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
