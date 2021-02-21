import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/components/circular_progress_about.dart';
import 'package:pokedex_flutter/models/species.dart';
import 'package:pokedex_flutter/stores/pokeapi_store.dart';
import 'package:pokedex_flutter/stores/pokeapiv2_store.dart';

class TabAbout extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
  final PokeApiStore _pokeApiStore = GetIt.instance<PokeApiStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Observer(builder: (context) {
              Species _species = _pokeApiV2Store.species;
              return SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  child: _species != null
                      ? Text(
                          _species.flavorTextEntries
                              .where((item) => item.language.name == 'en')
                              .first
                              .flavorText
                              .replaceAll("\n", " ")
                              .replaceAll("\f", " ")
                              .replaceAll("POKéMON", "Pokémon"),
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      : CircularProgressAbout(),
                ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Text(
              'Biology',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200),
              child: Observer(builder: (context) {
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Height',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          _pokeApiStore.pokemonCurrent.height,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Weight',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          _pokeApiStore.pokemonCurrent.weight,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
