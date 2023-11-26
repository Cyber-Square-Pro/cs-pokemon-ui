import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../enums/device_screen_type.dart';

class AppBarWidget extends StatefulWidget {
  final bool showBackButton;
  final String title;
  final String? lottiePath;

  const AppBarWidget({
    Key? key,
    required this.title,
    this.lottiePath,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.light,
      automaticallyImplyLeading: widget.showBackButton,
      stretch: true,
      pinned: true,
      snap: false,
      floating: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      expandedHeight: 170.0,
      collapsedHeight: 100,
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue.shade800,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        background: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/bg/login_bg.png',
                fit: BoxFit.cover,
              ),
              if (widget.lottiePath != null)
                Positioned(
                  bottom: 12,
                  right: 0,
                  child: Lottie.asset(
                    widget.lottiePath!,
                    height: 140,
                    width: 140,
                  ),
                )
              else
                SizedBox(),
            ],
          ),
        ),
        // background: widget.lottiePath != null
        //     ? Align(
        //         alignment: Alignment.bottomRight,
        //         child: Lottie.asset(widget.lottiePath!, height: 140.0),
        //       )
        //     : Container(),
        titlePadding: const EdgeInsets.only(left: 15, bottom: 10),
        title: Row(
          children: [
            const AnimatedPokeballWidget(
              size: 21,
              color: Colors.white,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Circular',
                letterSpacing: -0.5,
              ),
            ),
            if (kIsWeb && getDeviceScreenType(context) != DeviceScreenType.CELLPHONE)
              const SizedBox(
                width: 5,
              ),
            if (kIsWeb && getDeviceScreenType(context) != DeviceScreenType.CELLPHONE)
              Image.network(
                AppConstants.getRandomPokemonGif(),
                height: 32,
              )
          ],
        ),
      ),
    );
  }
}
