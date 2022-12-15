import 'package:flutter/material.dart';
import '../../services/models/season_dto.dart';

class SeasonsListViewItem extends StatelessWidget {
  Seasons model;

  SeasonsListViewItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(model.season ?? "-"),
    );
  }
}
