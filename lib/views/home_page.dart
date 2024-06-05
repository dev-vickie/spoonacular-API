// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spoonacular/api_calls.dart';
import 'package:spoonacular/models/recipe.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe search app"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(child: TextField(
                  controller: _searchController,
                )),
                IconButton(
                  onPressed: () {
                    setState(() {
                      
                    });
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiServices.getRecipes(_searchController.text),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("An error has occured"),
                  );
                } else {
                  final recipes = snapshot.data as List<Recipe>;
                  if (recipes.isEmpty) {
                    return Center(
                      child: Text("No recipes found"),
                    );
                  }

                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final recipe = recipes[index];
                      return ListTile(
                        leading: Image.network(recipe.image),
                        title: Text(recipe.title),
                      );
                    },
                  );
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
