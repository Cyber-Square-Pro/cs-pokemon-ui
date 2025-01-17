import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/ui/widgets/image_dialog.dart';
import 'package:app/shared/utils/hero_dialog_route.dart';
import 'package:app/shared/utils/image_utils.dart';
import 'package:app/theme/app_theme.dart';

import '../../../pokemon_mobile_panel.dart';

class PokemonCardsWidget extends StatefulWidget {
  const PokemonCardsWidget({Key? key}) : super(key: key);

  @override
  PokemonCardsWidgetState createState() => PokemonCardsWidgetState();
}

class PokemonCardsWidgetState extends State<PokemonCardsWidget> {
  static final _pokemonStore = GetIt.instance<PokemonStore>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double getViewportFraction(Size size) {
    double? viewportFraction = 0;

    if (size.width > 1200) {
      viewportFraction = 0.18;
    } else if (size.width > 900) {
      viewportFraction = 0.22;
    } else if (size.width > 600) {
      viewportFraction = 0.35;
    } else {
      viewportFraction = 0.5;
    }

    return viewportFraction;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;

    double? viewportFraction = getViewportFraction(size);
    final horizontalPadding = getDetailsPanelsPadding(size);

    _pageController =
        PageController(initialPage: 0, viewportFraction: viewportFraction);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Observer(
                builder: (_) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    "${_pokemonStore.pokemon!.name} Cards",
                    style: textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Observer(
                  builder: (_) => PageView.builder(
                    controller: _pageController,
                    allowImplicitScrolling: true,
                    itemCount: _pokemonStore.pokemon!.cards.length,
                    itemBuilder: (context, index) {
                      final card = _pokemonStore.pokemon!.cards[index];

                      return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              HeroDialogRoute(
                                builder: (BuildContext context) {
                                  return ImageDialogWidget(
                                      tag:
                                          "${card.name}-${card.number}- ${card.expansionName}",
                                      imageUrl: card.imageUrl);
                                },
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Hero(
                                tag:
                                    "${card.name}-${card.number}- ${card.expansionName}",
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.fromBorderSide(
                                        BorderSide(
                                            color: AppTheme.getColors(context)
                                                .tabDivisor),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.08),
                                          blurRadius: 4.0,
                                          spreadRadius: 3.0,
                                          offset: const Offset(
                                            0.0,
                                            4.0,
                                          ),
                                        ),
                                      ]),
                                  child: ImageUtils.networkImage(
                                    url: card.imageUrl,
                                  ),
                                ),
                              ),
                              Text(
                                "${card.number} - ${card.name}",
                                style: textTheme.bodySmall,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  card.expansionName,
                                  style: textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              )
            ],
          ),
        ],
      ),
    );
  }
}
