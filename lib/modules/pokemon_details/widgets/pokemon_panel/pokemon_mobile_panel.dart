import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/about/about_page.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/base_stats/base_stats_page.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/evolution/evolution_page.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/moves/moves_page.dart';
import 'package:app/shared/ui/enums/device_screen_type.dart';
import 'package:app/theme/app_theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

double getDetailsPanelsPadding(Size size) {
  double horizontalPadding = 0;

  if (size.width > 1200) {
    horizontalPadding = size.width * 0.28;
  } else if (size.width > 900) {
    horizontalPadding = size.width * 0.2;
  } else if (size.width > 600) {
    horizontalPadding = 28;
  } else {
    horizontalPadding = 28;
  }

  return horizontalPadding;
}

class PokemonMobilePanelWidget extends StatefulWidget {
  final Function(double position) listener;

  const PokemonMobilePanelWidget({
    Key? key,
    required this.listener,
  }) : super(key: key);

  @override
  PokemonMobilePanelWidgetState createState() =>
      PokemonMobilePanelWidgetState();
}

class PokemonMobilePanelWidgetState extends State<PokemonMobilePanelWidget>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<PokemonMobilePanelWidget> {
  late TabController _tabController;
  late PanelController _panelController;
  late ScrollController _aboutScrollController;
  late ScrollController _baseStatsController;
  late ScrollController _evolutionController;
  late ScrollController _movesController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 4);
    _panelController = PanelController();
    _aboutScrollController = ScrollController();
    _baseStatsController = ScrollController();
    _evolutionController = ScrollController();
    _movesController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  void onScroll(UserScrollNotification scrollInfo) {
    if (kIsWeb ||
        io.Platform.isWindows ||
        io.Platform.isLinux ||
        io.Platform.isMacOS) {
      if (scrollInfo.metrics.pixels > 0) {
        if (!_panelController.isPanelOpen) {
          _panelController.open();
        }
      }

      if (scrollInfo.metrics.pixels == 0) {
        if (_panelController.isPanelOpen) {
          _panelController.close();
        }
      }
    }
  }

  ScrollController? setScrollControllerByPlatform(
      BuildContext context, ScrollController scrollController) {
    return (kIsWeb &&
                getDeviceScreenType(context) != DeviceScreenType.cellphone) ||
            (!kIsWeb && !io.Platform.isAndroid && !io.Platform.isIOS)
        ? scrollController
        : null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final TextTheme textTheme = Theme.of(context).textTheme;

    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 1,
      minHeight: MediaQuery.of(context).size.height * 0.50,
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      controller: _panelController,
      color: Theme.of(context).colorScheme.background,
      panelBuilder: (scrollController) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    leading: Container(),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    pinned: true,
                    centerTitle: true,
                    flexibleSpace: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: TabBar(
                            unselectedLabelColor:
                                AppTheme.getColors(context).pokemonTabTitle,
                            labelColor: AppTheme.getColors(context)
                                .selectPokemonTabTitle,
                            unselectedLabelStyle: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            labelStyle: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: null,
                            ),
                            indicatorColor:
                                AppTheme.getColors(context).tabIndicator,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("About",
                                      style: textTheme.bodyMedium),
                                ),
                              ),
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("Base Stats",
                                      style: textTheme.bodyMedium),
                                ),
                              ),
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("Evolution",
                                      style: textTheme.bodyMedium),
                                ),
                              ),
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text("Moves",
                                      style: textTheme.bodyMedium),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    NotificationListener<UserScrollNotification>(
                      child: SingleChildScrollView(
                        controller: setScrollControllerByPlatform(
                            context, _aboutScrollController),
                        child: const AboutPage(),
                      ),
                      onNotification: (UserScrollNotification scrollInfo) {
                        onScroll(scrollInfo);

                        return true;
                      },
                    ),
                    NotificationListener<UserScrollNotification>(
                      child: SingleChildScrollView(
                        controller: setScrollControllerByPlatform(
                            context, _baseStatsController),
                        child: const BaseStatsPage(),
                      ),
                      onNotification: (UserScrollNotification scrollInfo) {
                        onScroll(scrollInfo);

                        return true;
                      },
                    ),
                    NotificationListener<UserScrollNotification>(
                      child: SingleChildScrollView(
                        controller: setScrollControllerByPlatform(
                            context, _evolutionController),
                        child: const EvolutionPage(),
                      ),
                      onNotification: (UserScrollNotification scrollInfo) {
                        onScroll(scrollInfo);

                        return true;
                      },
                    ),
                    NotificationListener<UserScrollNotification>(
                      child: SingleChildScrollView(
                        controller: setScrollControllerByPlatform(
                            context, _movesController),
                        child: const MovesPage(),
                      ),
                      onNotification: (UserScrollNotification scrollInfo) {
                        onScroll(scrollInfo);

                        return true;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      onPanelSlide: widget.listener,
      boxShadow: null,
    );
  }
}
