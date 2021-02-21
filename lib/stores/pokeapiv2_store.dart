import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex_flutter/consts/consts_api.dart';
import 'package:pokedex_flutter/models/pokeapiv2.dart';
import 'package:pokedex_flutter/models/species.dart';
import 'package:http/http.dart' as http;
part 'pokeapiv2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {
  @observable
  Species species;

  @observable
  PokeApiV2 pokeApiV2;

  @action
  Future<void> getInfoPokemon(String name) async {
    try {
      final response =
          await http.get(ConstsAPI.pokeapiv2URL + name.toLowerCase());
      var decodeJson = jsonDecode(response.body);
      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Error loading list" + stacktrace.toString());
      return null;
    }
  }

  @action
  Future<void> getInfoSpecies(String numPokemon) async {
    try {
      final response = await http.get(ConstsAPI.pokeapiv2speciesURL + numPokemon);
      var decodeJson = jsonDecode(response.body);
      species = Species.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Error loading list" + stacktrace.toString());
      return null;
    }
  }
}
