import 'package:flutter/material.dart';
import 'pokemon.dart';

class Info extends StatelessWidget {
  final Pokemon pokemon;

  Info(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 0, 0, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Column(children: [
            Text(
              pokemon.name,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ]),
          SizedBox(height: 30),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.red),
                          color: Colors.grey),
                      child: Image(
                        image: NetworkImage(pokemon.sprites.frontDefault),
                        fit: BoxFit.fill,
                        width: 200,
                        height: 200,
                      ))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              'Type',
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
                height: 65,
                child: Center(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: pokemon.types.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          margin:
                              EdgeInsets.symmetric(horizontal: 92, vertical: 1),
                          child: Text(
                            pokemon.types[index].type.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(width: 3),
                              color: Colors.grey),
                        );
                      }),
                )),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Weight:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.red)),
                  Text('${pokemon.weight / 10} kg',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Text('Height:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.red)),
                  Text('${pokemon.height / 10} m',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ],
              ),
            ],
          ),
          Text(
            "Status:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: pokemon.stats.length,
                itemBuilder: (context, index) {
                  final poke = pokemon.stats[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          '${poke.stat.name} = ${poke.baseStat}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
