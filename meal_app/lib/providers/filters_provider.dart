import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final filterProvider=StateNotifierProvider<FilterProvider,Map<Filter,bool>>( (ref)=> FilterProvider()  );