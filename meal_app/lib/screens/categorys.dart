import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widget/category_grid_item.dart';
import 'package:meal_app/screens/meals.dart';

class CategoryScreen extends StatelessWidget{
  const CategoryScreen({super.key,required this.avalibleMeals});


  final List<Meal> avalibleMeals;
  void _selectCategory(BuildContext context, Category category){
    final filteredMeals=avalibleMeals
    .where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: 
      (ctx) =>  MealsScreen(
        title: category.title,
        meals: filteredMeals,

        ),
        ),
        ) ; //or Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
          children:  [
            for(final category in availableCategories)
            CategoryGridItem(
              category: category,
            onSelectedCategory: (){_selectCategory(context,category);},)
          ],
      ),
    );
  }
}