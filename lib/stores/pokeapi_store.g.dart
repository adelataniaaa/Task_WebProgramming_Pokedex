// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  Computed<PokeAPI> _$pokeAPIComputed;

  @override
  PokeAPI get pokeAPI =>
      (_$pokeAPIComputed ??= Computed<PokeAPI>(() => super.pokeAPI,
              name: '_PokeApiStoreBase.pokeAPI'))
          .value;
  Computed<Pokemon> _$pokemonCurrentComputed;

  @override
  Pokemon get pokemonCurrent => (_$pokemonCurrentComputed ??= Computed<Pokemon>(
          () => super.pokemonCurrent,
          name: '_PokeApiStoreBase.pokemonCurrent'))
      .value;

  final _$_pokeAPIAtom = Atom(name: '_PokeApiStoreBase._pokeAPI');

  @override
  PokeAPI get _pokeAPI {
    _$_pokeAPIAtom.reportRead();
    return super._pokeAPI;
  }

  @override
  set _pokeAPI(PokeAPI value) {
    _$_pokeAPIAtom.reportWrite(value, super._pokeAPI, () {
      super._pokeAPI = value;
    });
  }

  final _$_pokemonCurrentAtom = Atom(name: '_PokeApiStoreBase._pokemonCurrent');

  @override
  Pokemon get _pokemonCurrent {
    _$_pokemonCurrentAtom.reportRead();
    return super._pokemonCurrent;
  }

  @override
  set _pokemonCurrent(Pokemon value) {
    _$_pokemonCurrentAtom.reportWrite(value, super._pokemonCurrent, () {
      super._pokemonCurrent = value;
    });
  }

  final _$colPokemonAtom = Atom(name: '_PokeApiStoreBase.colPokemon');

  @override
  dynamic get colPokemon {
    _$colPokemonAtom.reportRead();
    return super.colPokemon;
  }

  @override
  set colPokemon(dynamic value) {
    _$colPokemonAtom.reportWrite(value, super.colPokemon, () {
      super.colPokemon = value;
    });
  }

  final _$positionCurrentAtom = Atom(name: '_PokeApiStoreBase.positionCurrent');

  @override
  int get positionCurrent {
    _$positionCurrentAtom.reportRead();
    return super.positionCurrent;
  }

  @override
  set positionCurrent(int value) {
    _$positionCurrentAtom.reportWrite(value, super.positionCurrent, () {
      super.positionCurrent = value;
    });
  }

  final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase');

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.fetchPokemonList');
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPokemonCurrent({int index}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.setPokemonCurrent');
    try {
      return super.setPokemonCurrent(index: index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImage({String number}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.getImage');
    try {
      return super.getImage(number: number);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
colPokemon: ${colPokemon},
positionCurrent: ${positionCurrent},
pokeAPI: ${pokeAPI},
pokemonCurrent: ${pokemonCurrent}
    ''';
  }
}
