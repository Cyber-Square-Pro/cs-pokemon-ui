import 'package:app/modules/merch/widgets/favourite_print_picker.dart';
import 'package:app/modules/merch/widgets/shirt_provider.dart';
import 'package:app/modules/merch/widgets/tshirt_color_picker.dart';
import 'package:app/shared/providers/favourites_provider.dart';
import 'package:app/shared/utils/spacer.dart';
import 'package:app/shared/widgets/primary_elevated_button.dart';
import 'package:app/theme/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TShirtsPage extends StatefulWidget {
  const TShirtsPage({super.key});

  @override
  State<TShirtsPage> createState() => _TShirtsPageState();
}

class _TShirtsPageState extends State<TShirtsPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await context.read<FavouritesProvider>().fetchFavourites(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppLayouts.horizontalPagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Build your own pokemon Shirt!',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                ),
                hSpace(10),
                Text(
                  '1.Select your shirt color',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 0,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                hSpace(10),
                Text(
                  '2.Click the \'Select Pokemon\' Button to pick your pokemon print',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 0,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
                hSpace(10),
                Text(
                  '3.Click the \'Finalize\' Button to finish building',
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 0,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                ),
              ],
            ),
            hSpace(10),
            Consumer<FavouritesProvider>(
              builder: (context, provider, _) {
                return const TShirtBuilder();
              },
            ),
            hSpace(10),
            const Text('Pick a shirt color'),
            hSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainElevatedButton(
                  label: 'Select Pokemon',
                  icon: Icons.add,
                  onPressed: () {
                    showFavouritePickerDialog(context);
                  },
                ),
                wSpace(10),
                MainElevatedButton(
                  label: 'Finalize',
                  icon: Icons.check,
                  onPressed:
                      context.watch<ShirtProvider>().selectedPokemon != null
                          ? () {
                              // Navigator.push(
                              //   context,
                              //   TransitionPageRoute(
                              //     child: const SelectPokemonPrintPage(),
                              //     transition: PageTransitions.slideLeft,
                              //   ),
                              // );
                            }
                          : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
