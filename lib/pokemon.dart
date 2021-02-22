import 'dart:convert';

class Poke {
  String name, url;

  Poke({this.name, this.url});

  factory Poke.fromJson(Map<String, dynamic> data) {
    return Poke(name: data["name"], url: data["url"]);
  }
}

class Species {
  String name, url;

  Species({this.name, this.url});

  factory Species.fromJson(Map<String, dynamic> data) =>
      Species(name: data["name"], url: data["url"]);
}

class Pokemons {
  List<Poke> x = [];
  Pokemons({this.x});
  Pokemons.fromJson(List<dynamic> data) {
    if (data == null) return;

    data.forEach((barang) {
      final pokemon = Poke.fromJson(barang);
      x.add(pokemon);
    });
  }
}

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

class Pokemon {
  int id, weight, height;
  List<Stat> stats;
  List<Type> types;
  String name;
  Sprites sprites;

  Pokemon(
      {this.id,
      this.weight,
      this.height,
      this.name,
      this.stats,
      this.types,
      this.sprites});

  factory Pokemon.fromJson(Map<String, dynamic> data) => Pokemon(
      id: data["id"],
      weight: data["weight"],
      height: data["height"],
      stats: List<Stat>.from(data["stats"].map((x) => Stat.fromJson(x))),
      types: List<Type>.from(data["types"].map((x) => Type.fromJson(x))),
      name: data["name"],
      sprites: Sprites.fromJson(data["sprites"]));
}

class Type {
  int slot;
  Species type;

  Type({
    this.slot,
    this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
      );
}

class Stat {
  int baseStat;
  Species stat;

  Stat({
    this.baseStat,
    this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> data) =>
      Stat(baseStat: data["base_stat"], stat: Species.fromJson(data["stat"]));
}

class Sprites {
  String frontDefault;
  Sprites({this.frontDefault});

  factory Sprites.fromJson(Map<String, dynamic> data) =>
      Sprites(frontDefault: data["front_default"]);
}
