import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final perliculasProvider = new PeliculasProvider();
  final peliculas = [
    'Spiderman',
    'Thor',
    'Doctor Strange',
    'WandaVision',
    'Iron Man',
    'Loki',
    'Avengers End Game',
    'Volver Al Futuro',
    'Venom',
    'Capitan America y el Soldado del Invierno',
    'Black Panther',
    'Black Widow',
    'The Eternals',
  ];
  final peliculasRecientes = [
    'Venom',
    'Capitan America y el Soldado del Invierno',
    'Black Panther',
    'Black Widow',
    'The Eternals',
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Las Acciones de nuestro AppBar
    //throw UnimplementedError();
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del Appbar
    //throw UnimplementedError();
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          //progress: _animationController,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    //throw UnimplementedError();
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.yellowAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    //throw UnimplementedError();

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: perliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map((pelicula) {
              return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterIMG()),
                    placeholder: AssetImage('assets/img/no-image.png'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle',
                        arguments: pelicula);
                  });
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /*  @override
  Widget buildSuggestions(BuildContext context) {
    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    // Son las sugerencias que aparecen cuando la persona escribe
    //throw UnimplementedError();
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );
  } */
}
