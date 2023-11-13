import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/widget/category_grid_item.dart';
import 'package:meal_app/screens/meals.dart';

class CategoryScreen extends StatefulWidget{
  const CategoryScreen({super.key,required this.avalibleMeals});


  final List<Meal> avalibleMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
      );
      _animationController.forward();
  }

  @override
  void dispose() {//make sure you don't cause mamory overflow (important)
    _animationController.dispose();
    super.dispose();
  }
  void _selectCategory(BuildContext context, Category category){
    final filteredMeals=widget.avalibleMeals
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
    return AnimatedBuilder(
      animation: _animationController, 
      child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
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
    ),
      builder: (context,child)=>SlideTransition(
        position:Tween(
            begin: const Offset(0,0.3), //Get Coordinations x-axis & y-axis
            end: const Offset(0,0),
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,//make the animation more natural fast at begning & end and slow in between.
          ),
        ) ,//animate
        child: child,),
        );
    
  }
}