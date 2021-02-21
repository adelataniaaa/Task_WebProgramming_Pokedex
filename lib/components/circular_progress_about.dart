import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/stores/pokeapi_store.dart';

class CircularProgressAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  GetIt.instance<PokeApiStore>().colPokemon),
            )),
      ),
    );
  }
}
