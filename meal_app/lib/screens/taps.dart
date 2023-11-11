import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categorys.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widget/drawer.dart';
import 'package:meal_app/providers/meals_provider.dart';
import 'package:meal_app/providers/favorites_providers.dart';
import 'package:meal_app/providers/filters_provider.dart';

class TapsScreen extends ConsumerStatefulWidget{
  const TapsScreen({super.key, });

@override
  ConsumerState<TapsScreen> createState() {
    return _TapScreenState();
  }
}

const kIntialFilters={
Filter.glutenFree:false,
    Filter.lactuseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
};

class _TapScreenState extends ConsumerState<TapsScreen>{
  void _showInfoMassage(String massage){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage)));
  }

  int _selectedPageIndex=0;
  // final List<Meal> _favoriteMeals=[];
  // Map<Filter,bool> _selectedFilter=kIntialFilters;

  // void _toggleMealFavoviteState(Meal meal){
  //   final isExisting=_favoriteMeals.contains(meal);
  //   if(isExisting){//if exist in the favorit list already go remove the meal
  //   setState(() {
  //     _favoriteMeals.remove(meal);
  //     _showInfoMassage('Meal no longer Favorite ');
  //   });
  //   }else{//if it is not existing in the favorit list go add the meal
  //   setState(() {
  //     _favoriteMeals.add(meal);
  //     _showInfoMassage('Meal add to Favorite Menu');
  //   });
  //   }
  // }

  void _selectedPage(index){
    setState(() {
      _selectedPageIndex=index;
    });
  }

  void _setScreen(String identifier)async{
    Navigator.of(context).pop();
    if(identifier=='filters'){
      // final result =
      await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(builder: (ctx)=> const FiltersScreen()
        ),
      );
    // setState(() {
    //   _selectedFilter=result ?? kIntialFilters;
    // });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final meals=ref.watch(mealProvider);
    final activeFilters=ref.watch(filterProvider);
    
    final avalibaleMeals=meals.where((meal){
      if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(activeFilters[Filter.lactuseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(activeFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(activeFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
    Widget activePage=CategoryScreen(avalibleMeals: avalibaleMeals,);
    var  activeTitle='Category';
    if(_selectedPageIndex==1){
      final favoiteMeals=ref.watch(favoriteMealsProvider);
    activePage=  MealsScreen( 
      meals: favoiteMeals,
);
    activeTitle='Your Favorits';
  }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: DrawerWidget(onSelectScreen: _setScreen,) ,
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectedPage,
        items:const  [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favorits'),
        ],
      ),
    );
  }
}