import 'package:flutter/material.dart';
import '../language_constants.dart';
import '../main.dart';
import '../services/models/season_dto.dart';
import '../services/season_api.dart';

class SeasonsScreen extends StatefulWidget {
  const SeasonsScreen({super.key});

  @override
  State<SeasonsScreen> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends State<SeasonsScreen> {
  late Future<SeasonDTO?> seasonDTO;

  Future<SeasonDTO?> _init() async {
    return getIt<SeasonAPI>().getSeasons();
  }

  @override
  void initState() {
    super.initState();

    seasonDTO = _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<SeasonDTO?>(
          future: seasonDTO,
          builder: (BuildContext context, AsyncSnapshot<SeasonDTO?> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data!.mRData != null) {
                return const Text("Találtunk!");
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
      ),
    );
  }
}
