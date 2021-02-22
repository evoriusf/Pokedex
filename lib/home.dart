import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'info.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class PokeHome extends StatefulWidget {
  static const String url =
      'https://pokeapi.co/api/v2/pokemon?limit=151&offset=0';

  @override
  _PokeHomeState createState() => _PokeHomeState();
}

class _PokeHomeState extends State<PokeHome> {
  Pokemons pokemons;
  SearchBar searchBar;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              _fetchData();
            }),
        title: new Text('Pokedex'),
        backgroundColor: Color.fromRGBO(255, 0, 0, 1),
        actions: [searchBar.getSearchAction(context)]);
  }

  void _fetchData() async {
    final response = await http.get(PokeHome.url);
    final decode = json.decode(response.body);
    final data = Pokemons.fromJson(decode['results']);

    setState(() {
      pokemons = data;
    });
  }

  void initState() {
    _fetchData();
    super.initState();
  }

  void onSubmitted(String value) async {
    final response = await http.get(PokeHome.url);
    final decode = json.decode(response.body);
    final data = Pokemons.fromJson(decode['results']);
    final filter =
        data.x.where((pokemon) => pokemon.name.contains(value)).toList();
    setState(() {
      pokemons = new Pokemons(x: filter);
    });
  }

  _PokeHomeState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(50, 50, 50, 0.8),
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: Container(
        child: pokemons == null
            ? Center(
                child: LinearProgressIndicator(),
              )
            : GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(
                    pokemons.x.length,
                    (index) => Kado(
                          key: ValueKey(pokemons.x[index].name),
                          url: 'https://pokeapi.co/api/v2/pokemon/' +
                              pokemons.x[index].name,
                        )),
              ),
      ),
    );
  }
}

class Kado extends StatefulWidget {
  const Kado({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _KadoState createState() => _KadoState();
}

class _KadoState extends State<Kado> {
  Pokemon pokemon;

  _fetchData() async {
    final response = await http.get(widget.url);
    final decode = json.decode(response.body);
    final data = Pokemon.fromJson(decode);
    if (mounted)
      setState(() {
        pokemon = data;
      });
  }

  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 6, 4, 0),
      child: Card(
          child: InkWell(
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => Info(pokemon)));
        },
        child: pokemon == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                  Color.fromRGBO(255, 0, 0, 1),
                  Color.fromRGBO(255, 0, 0, 1)
                ], stops: [
                  0.0,
                  0.75,
                  0.75,
                  1.0
                ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
                child: Column(children: [
                  Image.network(
                    pokemon.sprites.frontDefault,
                    width: 100,
                    fit: BoxFit.fill,
                    alignment: Alignment.centerLeft,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(
                        fontSize: 20,
                        height: 2,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                ])),
      )),
    );
  }
}
