import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:app/modules/pokemon_details/widgets/pokemon_panel/pages/moves/widgets/table_moves.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/ui/widgets/pokemon_type_badge.dart';

import '../../moves_store.dart';

class TechnicalRecordsMovesTableWidget extends StatelessWidget {
  static final PokemonStore _pokemonStore = GetIt.instance<PokemonStore>();
  final MovesStore movesStore;
  final int index;

  const TechnicalRecordsMovesTableWidget(
      {Key? key, required this.movesStore, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Observer(builder: (_) {
      if (movesStore.panels[index]) {
        return TableMovesWidget(
          columns: [
            Text("TR",
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
            Text("Move",
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
            Text("Type",
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
            Text("Cat.",
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
            Text("Power",
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
            Text("Acc.",
                style:
                    textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
          ],
          rows: _pokemonStore.pokemon!.moves.technicalRecords
              .map((move) => [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/technical_records_types/TR_${move.type}.png",
                          width: 25,
                          height: 23,
                        ),
                        Text(move.technicalRecord.toString(),
                            style: textTheme.bodySmall),
                      ],
                    ),
                    Text(move.move, style: textTheme.bodySmall),
                    PokemonTypeBadge(type: move.type, height: 16, width: 16),
                    Text(move.category, style: textTheme.bodySmall),
                    Text(move.power, style: textTheme.bodySmall),
                    Text(move.accuracy, style: textTheme.bodySmall)
                  ])
              .toList(),
        );
      } else {
        return Container();
      }
    });
  }
}
