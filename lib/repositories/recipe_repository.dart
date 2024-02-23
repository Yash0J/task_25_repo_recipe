import 'package:task_25_repo_recipe/models/recipe_model.dart';
import 'recipe_api_service.dart';

class RecipeRepository {
  final RecipeApiService apiService;
  RecipeRepository(this.apiService);
  Future<List<Recipe>> getRecipes() async {
    return await RecipeApiService.fetchRecipes();
  }
}
