import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_25_repo_recipe/models/recipe_model.dart';

class RecipeApiService {
  static Future<List<Recipe>> fetchRecipes() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {
      "limit": "22",
      "start": "0",
      "tag": "list.recipe.popular",
    });

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': '265d932c77msha378875aaf13249p165bf2jsnd59703aaf21f',
      'X-RapidAPI-Host': 'yummly2.p.rapidapi.com'
    });

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List<Map<String, dynamic>> temp = [];

      for (var i in data['feed']) {
        temp.add(i['content']['details']);
      }

      return Recipe.recipesFromSnapshot(temp);
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }
}
