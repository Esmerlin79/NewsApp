import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {

  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
   
   final headLines = Provider.of<NewsService>(context).headline;

    return Scaffold(
      body: ( headLines.length == 0 )
      ? Center(child: CircularProgressIndicator(),)
      : ListaNoticias( headLines )
    );
  }

  @override
  bool get wantKeepAlive => true;
}