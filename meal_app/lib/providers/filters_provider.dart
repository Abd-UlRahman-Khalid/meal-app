import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactuseFree,
  vegetarian,
  vegan,
}

class FilterProvider extends StateNotifier<Map<Filter,bool>>{
  FilterProvider ():super({
    Filter.glutenFree:false,
    Filter.lactuseFree:false,
    Filter.vegetarian:false,
    Filter.vegan:false,
  });
  void setFilters(Map<Filter,bool> choosenFilter){
    state=choosenFilter;
  }

  void setFilter(Filter filter,bool isActive){
    state={
      ...state,filter:isActive
    };
  }
}

final filterProvider=StateNotifierProvider<FilterProvider,Map<Filter,bool>>( 
  (ref)=>FilterProvider()  );
  
final filteredMealProvider=Provider((ref){
  final meals=ref.watch(mealProvider);
  final activeFilters=ref.watch(filterProvider);
  return meals.where((meal){
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
});