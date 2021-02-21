import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/consts/consts_app.dart';
import 'package:pokedex_flutter/models/pokeapi.dart';
import 'package:pokedex_flutter/pages/about_page/about_page.dart';
import 'package:pokedex_flutter/stores/pokeapi_store.dart';
import 'package:pokedex_flutter/stores/pokeapiv2_store.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class PokeDetailPage extends StatefulWidget {
  final int index;
  PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  PageController _pageController;
  PokeApiStore _pokemonStore;
  PokeApiV2Store _pokeApiV2Store;
  // ignore: deprecated_member_use
  MultiTrackTween _animation;
  double _progress;
  double _multiple;
  double _opacity;
  double _opacityTitleAppBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
    _pokeApiV2Store.getInfoPokemon(_pokemonStore.pokemonCurrent.name);
    _pokeApiV2Store.getInfoSpecies(_pokemonStore.pokemonCurrent.id.toString());
    // ignore: deprecated_member_use
    _animation = MultiTrackTween([
      // ignore: deprecated_member_use
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);
    _progress = 0;
    _multiple = 1;
    _opacity = 1;
    _opacityTitleAppBar = 0;
  }

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress = lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _pokemonStore.colPokemon.withOpacity(0.7),
                      _pokemonStore.colPokemon,
                    ],
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    AppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      actions: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  // ignore: deprecated_member_use
                                  ControlledAnimation(
                                      // ignore: deprecated_member_use
                                      playback: Playback.LOOP,
                                      duration: _animation.duration,
                                      tween: _animation,
                                      builder: (context, animation) {
                                        return Transform.rotate(
                                          angle: animation['rotation'],
                                          child: Opacity(
                                            child: Image.asset(
                                              ConstsApp.whitePokeball,
                                              height: 50,
                                              width: 50,
                                            ),
                                            opacity: _opacityTitleAppBar >= 0.2
                                                ? 0.2
                                                : 0.0,
                                          ),
                                        );
                                      }),
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.16 -
                          _progress *
                              (MediaQuery.of(context).size.height * 0.060),
                      left: 20 +
                          _progress *
                              (MediaQuery.of(context).size.height * 0.060),
                      child: Text(
                        _pokemonStore.pokemonCurrent.name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 30 -
                                _progress *
                                    (MediaQuery.of(context).size.height *
                                        0.011),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.19,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              setTypes(_pokemonStore.pokemonCurrent.type),
                              Text(
                                  '#' +
                                      _pokemonStore.pokemonCurrent.num
                                          .toString(),
                                  style: TextStyle(
                                    fontFamily: 'Google',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 300),
              );
            },
          ),
          SlidingSheet(
            listener: (state) {
              setState(() {
                _progress = state.progress;
                _multiple = 1 - interval(0.55, 0.85, _progress);
                _opacity = _multiple;
                _opacityTitleAppBar =
                    _multiple = interval(0.55, 0.85, _progress);
              });
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.6, 0.85],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.16,
                child: AboutPage(),
              );
            },
          ),
          Opacity(
            opacity: _opacity,
            child: Padding(
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokemonStore.setPokemonCurrent(index: index);
                    _pokeApiV2Store
                        .getInfoPokemon(_pokemonStore.pokemonCurrent.name);
                    _pokeApiV2Store.getInfoSpecies(
                        _pokemonStore.pokemonCurrent.id.toString());
                  },
                  itemCount: _pokemonStore.pokeAPI.pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pokemon _pokeitem = _pokemonStore.getPokemon(index: index);
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // ignore: deprecated_member_use
                        ControlledAnimation(
                            // ignore: deprecated_member_use
                            playback: Playback.LOOP,
                            duration: _animation.duration,
                            tween: _animation,
                            builder: (context, _animation) {
                              return Transform.rotate(
                                angle: _animation['rotation'],
                                child: Opacity(
                                  child: Image.asset(
                                    ConstsApp.whitePokeball,
                                    height: 280,
                                    width: 280,
                                  ),
                                  opacity: 0.2,
                                ),
                              );
                            }),
                        IgnorePointer(
                          child: Observer(
                              name: 'Pokemon',
                              builder: (context) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    AnimatedPadding(
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.bounceInOut,
                                      padding: EdgeInsets.all(
                                          index == _pokemonStore.positionCurrent
                                              ? 0
                                              : 60),
                                      child: Hero(
                                        tag:
                                            index == _pokemonStore.positionCurrent
                                                ? _pokeitem.name
                                                : 'none' + index.toString(),
                                        child: CachedNetworkImage(
                                          height: 160,
                                          width: 160,
                                          placeholder: (context, url) =>
                                              new Container(
                                            color: Colors.transparent,
                                          ),
                                          color: index ==
                                                  _pokemonStore.positionCurrent
                                              ? null
                                              : Colors.black.withOpacity(0.5),
                                          imageUrl:
                                              'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeitem.num}.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    );
                  },
                ),
              ),
              padding: EdgeInsets.only(
                  top: _opacityTitleAppBar == 1
                      ? 1000
                      : (MediaQuery.of(context).size.height * 0.25) -
                          _progress * 50),
            ),
          )
        ],
      ),
    );
  }

  Widget setTypes(List<String> types) {
    List<Widget> list = [];
    types.forEach((name) {
      list.add(
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  name.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      );
    });
    return Row(
      children: list,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
