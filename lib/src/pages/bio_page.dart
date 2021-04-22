import 'package:flutter/material.dart';
import 'package:peliculas/src/models/people_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoImbd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Persona person = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: WebView(
        initialUrl: 'https://www.imdb.com/name/${person.imdbId}/',
      ),
    );
  }
}
