import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/models/pokeapi.dart';
import 'package:pokedex_flutter/stores/pokeapi_store.dart';

class TabEvolution extends StatelessWidget {
  final PokeApiStore _pokeApiStore = GetIt.instance<PokeApiStore>();

  Widget resizePokemon(Widget widget) {
    return SizedBox(height: 80, width: 80, child: widget);
  }

  List<Widget> getEvolution(Pokemon pokemon) {
    List<Widget> _list = [];
    if (pokemon.prevEvolution != null) {
      pokemon.prevEvolution.forEach((f) {
        _list.add(resizePokemon(_pokeApiStore.getImage(number: f.num)));
        _list.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              f.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        _list.add(Icon(Icons.keyboard_arrow_down));
      });
    }
    _list.add(resizePokemon(
        _pokeApiStore.getImage(number: _pokeApiStore.pokemonCurrent.num)));
    _list.add(
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Text(
          _pokeApiStore.pokemonCurrent.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    if (pokemon.nextEvolution != null) {
      pokemon.nextEvolution.forEach((f) {
        _list.add(Icon(Icons.keyboard_arrow_down));
        _list.add(resizePokemon(_pokeApiStore.getImage(number: f.num)));
        _list.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              f.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      });
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Observer(builder: (context) {
          Pokemon pokemon = _pokeApiStore.pokemonCurrent;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: getEvolution(pokemon),
            ),
          );
        }),
      ),
    );
  }
}
