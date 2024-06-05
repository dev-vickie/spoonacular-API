import 'dart:convert';

import 'package:flutter/material.dart';

import 'models/recipe.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<Recipe>> getRecipes(String query) async {
    debugPrint(query);
    final url =
        "https://api.spoonacular.com/recipes/complexSearch?query=$query&number=5";
    const apiKey = "816a378d99bf4bd5b3c2549d4533187d";
    try {
      final response = await http.post(Uri.parse(url), headers: {
        "x-api-key": apiKey,
      });
      debugPrint(response.body);
      if (response.statusCode != 200) {
        return <Recipe>[];
      }

      final responseJson = response.body; // json response

      final jsonData = jsonDecode(responseJson); //data inside the json

      final List<Recipe> recipes = [];

      for (final item in jsonData['results']) {
        recipes.add(Recipe.fromMap(item));
      }
      return recipes;
    } catch (e) {
      return <Recipe>[];
    }
  }
}
