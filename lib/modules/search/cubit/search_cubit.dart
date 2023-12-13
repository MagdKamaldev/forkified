import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  List<dynamic> recipes = [];
  String selectedRecipe = '';

  void fetchRecipes(String query) {
    emit(SearchLoading());
    DioHelper.getData(url:'recipes?search=$query').then((value) {
      recipes =
          value.data["documents"].map((e) => RecipeModel.fromJson(e)).toList();
      emit(SearchSuccess());
    });
  }
}
