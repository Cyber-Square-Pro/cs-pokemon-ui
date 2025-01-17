import 'package:flutter/material.dart';
import 'package:app/shared/models/pokemon.dart';
import 'package:app/shared/ui/canvas/white_pokeball_canvas.dart';
import 'package:app/shared/ui/widgets/image_dialog.dart';
import 'package:app/shared/utils/hero_dialog_route.dart';
import 'package:app/shared/utils/image_utils.dart';
import 'package:app/theme/app_theme.dart';

class EvolutionChainItemWidget extends StatelessWidget {
  final EvolutionChain previousEvolution;
  final EvolutionChain nextEvolution;

  const EvolutionChainItemWidget(
      {Key? key, required this.previousEvolution, required this.nextEvolution})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 83,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      HeroDialogRoute(
                        builder: (BuildContext context) {
                          return ImageDialogWidget(
                              tag:
                                  "prev-${previousEvolution.number}-${previousEvolution.name}",
                              imageUrl: previousEvolution.imageUrl);
                        },
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 83,
                        width: 83,
                        child: CustomPaint(
                          size: Size(83, (83 * 1.0040160642570282).toDouble()),
                          painter: PokeballLogoPainter(
                              color:
                                  AppTheme.getColors(context).pokeballLogoGray),
                        ),
                      ),
                      SizedBox(
                        height: 83,
                        width: 83,
                        child: Center(
                          child: Hero(
                            tag:
                                "prev-${previousEvolution.number}-${previousEvolution.name}",
                            child: ImageUtils.networkImage(
                              url: previousEvolution.thumbUrl,
                              width: 76,
                              height: 71,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  previousEvolution.name,
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "#${previousEvolution.number}",
                  style: textTheme.bodySmall?.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(
                Icons.arrow_forward,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  nextEvolution.requirement!,
                  style: textTheme.bodySmall?.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 83,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      HeroDialogRoute(
                        builder: (BuildContext context) {
                          return ImageDialogWidget(
                              tag:
                                  "next-${nextEvolution.number}-${nextEvolution.name}",
                              imageUrl: nextEvolution.imageUrl);
                        },
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 83,
                        width: 83,
                        child: CustomPaint(
                          size: Size(83, (83 * 1.0040160642570282).toDouble()),
                          painter: PokeballLogoPainter(
                              color:
                                  AppTheme.getColors(context).pokeballLogoGray),
                        ),
                      ),
                      SizedBox(
                        height: 83,
                        width: 83,
                        child: Center(
                          child: Hero(
                            tag:
                                "next-${nextEvolution.number}-${nextEvolution.name}",
                            child: ImageUtils.networkImage(
                              url: nextEvolution.thumbUrl,
                              width: 76,
                              height: 71,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  nextEvolution.name,
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "#${nextEvolution.number}",
                  style: textTheme.bodySmall?.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
