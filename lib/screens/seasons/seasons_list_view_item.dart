import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/models/season_dto.dart';

class SeasonsListViewItem extends StatelessWidget {
  Seasons model;

  SeasonsListViewItem({
    super.key,
    required this.model,
  });

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
    return Container(
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
    );
  }
}
