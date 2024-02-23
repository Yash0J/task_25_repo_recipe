// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:task_25_repo_recipe/models/recipe_model.dart';
import 'package:task_25_repo_recipe/repositories/recipe_api_service.dart';
import 'package:task_25_repo_recipe/repositories/recipe_repository.dart';
import 'package:task_25_repo_recipe/widget/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> recipes;
  bool isLoading = true;
  late RecipeRepository _recipeRepository;

  @override
  void initState() {
    super.initState();
    _recipeRepository = RecipeRepository(RecipeApiService());
    getRecipes();
  }

  Future<void> getRecipes() async {
    try {
      recipes = await _recipeRepository.getRecipes();
      setState(() {
        isLoading = false;
      });
      print(recipes);
    } catch (e) {
      print('Error fetching recipes: $e');
      // Handle error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Food Recipes'),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) => RecipeCard(
                title: recipes[index].name,
                cookTime: recipes[index].totalTime,
                rating: recipes[index].rating.toString(),
                thumbnailUrl: recipes[index].images,
              ),
            ),
    );
  }
}
