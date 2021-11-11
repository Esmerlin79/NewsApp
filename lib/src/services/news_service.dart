
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


// ignore: non_constant_identifier_names
final _URL_NEWS = 'https://newsapi.org/v2';
// ignore: non_constant_identifier_names
final _APIKEY = 'd32894b022494ce78852f1e5117c3a7f';

class NewsService with ChangeNotifier {


  List<Article> headline = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business' ),
    Category( FontAwesomeIcons.tv, 'entertainment' ),
    Category( FontAwesomeIcons.addressCard, 'general' ),
    Category( FontAwesomeIcons.headSideVirus, 'health' ),
    Category( FontAwesomeIcons.vials, 'science' ),
    Category( FontAwesomeIcons.volleyballBall, 'sports' ),
    Category( FontAwesomeIcons.memory, 'technology' ),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadline();

    categories.forEach((item) { 
      this.categoryArticles[item.name] = [];
    });

    this.getArticlesByCategory( _selectedCategory );
  }

  String get selectedCategory => this._selectedCategory;
  set selectedCategory( String valor ) {
    this._selectedCategory = valor;

    this.getArticlesByCategory( valor );
    notifyListeners();
  }

  get getArticulosCategoriaSeleccionada => this.categoryArticles[this.selectedCategory];

  getTopHeadline() async {
    
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );

    this.headline.addAll( newsResponse.articles );
    notifyListeners();
  }

  getArticlesByCategory( String category ) async {

    if(this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson( resp.body );

    this.categoryArticles[category]?.addAll(newsResponse.articles);
    
    notifyListeners();

  }

}