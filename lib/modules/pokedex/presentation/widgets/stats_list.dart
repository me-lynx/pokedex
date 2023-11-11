import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/modules/pokedex/data/models/pokemon.dart';
import 'package:pokedex/modules/pokedex/core/utils/string_extension.dart';

class BaseStatsList extends StatelessWidget {
  final List<Stats> stats;
  final Color? color;
  const BaseStatsList({Key? key, required this.stats, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return BaseStatsContainer(
            stats: stats[index],
            color: color,
          );
        });
  }
}

// ignore: must_be_immutable
class BaseStatsContainer extends StatelessWidget {
  final Stats stats;
  Color? color;
  BaseStatsContainer({Key? key, required this.stats, required this.color})
      : super(key: key);

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
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: .6),
                )),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
                width: width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: width),
                      child: Container(
                        width: (width * 2) * (stats.stat / 270),
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text("${stats.stat}/270",
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black.withOpacity(0.9),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
