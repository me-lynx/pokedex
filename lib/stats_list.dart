import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/feature/models/pokemon.dart';
import 'package:pokedex/helpers/string_extension.dart';

class BaseStatsList extends StatelessWidget {
  final List<Stats> stats;
  const BaseStatsList({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return BaseStatsContainer(stats: stats[index]);
        });
  }
}

class BaseStatsContainer extends StatelessWidget {
  final Stats stats;
  const BaseStatsContainer({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Text(stats.name.capitalize(),
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: .6),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: width * 0.7,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  Container(
                    width: stats.stat * 2,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text("${stats.stat}/270",
                          maxLines: 1,
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                letterSpacing: .6),
                          )),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
