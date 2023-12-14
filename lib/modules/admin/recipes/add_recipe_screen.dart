// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/modules/admin/recipes/ingredients_widget.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';

class AddRecipe extends StatefulWidget {
  final String categoryId;
  final String subCategoryId;
  AddRecipe({super.key, required this.categoryId, required this.subCategoryId});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  List<dynamic> ingredients = [];

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var descriptionController = TextEditingController();

  var prepTimeController = TextEditingController();

  var caloriesController = TextEditingController();

  bool isvegeterian = false;

  bool isDiet = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = RecipeCubit.get(context);
    return BlocConsumer<RecipeCubit, RecipeCubitState>(
      listener: (context, state) {
        if (state is AddRecipeSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Recipe",
            style: theme.displayLarge,
          ),
          toolbarHeight: size.height * 0.08,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultFormField(
                      size: size,
                        controller: nameController,
                        type: TextInputType.name,
                        onSubmit: () {},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Name must not be empty";
                          }
                        },
                        label: "Recipe Name",
                        prefix: Icons.category,
                        context: context),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    defaultFormField(
                      size: size,
                        controller: descriptionController,
                        type: TextInputType.name,
                        onSubmit: () {},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Description must not be empty";
                          }
                        },
                        label: "Recipe Description",
                        prefix: Icons.description,
                        context: context),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    defaultFormField(
                      size: size,
                        controller: caloriesController,
                        type: TextInputType.number,
                        onSubmit: () {},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Description must not be empty";
                          }
                        },
                        label: "Recipe Calories",
                        prefix: Icons.description,
                        context: context),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    defaultFormField(
                      size: size,
                        controller: prepTimeController,
                        type: TextInputType.number,
                        onSubmit: () {},
                        validate: (String value) {
                          if (value.isEmpty) {
                            return "Description must not be empty";
                          }
                        },
                        label: "Recipe Preptime (munites)",
                        prefix: Icons.description,
                        context: context),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Vegeterian",
                          style: theme.displayLarge!
                              .copyWith(color: isDark! ? cerulian : flame),
                        ),
                        Switch(
                            value: isvegeterian,
                            onChanged: (value) {
                              setState(() {
                                isvegeterian = value;
                              });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Diet",
                          style: theme.displayLarge!
                              .copyWith(color: isDark! ? cerulian : flame),
                        ),
                        Switch(
                            value: isDiet,
                            onChanged: (value) {
                              setState(() {
                                isDiet = value;
                              });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Image",
                      style: theme.displayLarge!
                          .copyWith(color: isDark! ? cerulian : flame),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    if (cubit.recipeImage != null)
                      Stack(children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isDark! ? cerulian : flame, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: size.width * 0.9,
                            height: size.height * 0.3,
                            child: Image.file(
                              cubit.recipeImage!,
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Container(
                                    width: size.width * 0.35,
                                    height: size.height * 0.1,
                                    color: isDark! ? prussianBlue : platinum,
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        color: isDark! ? cerulian : flame,
                                        size: size.height * 0.04,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: size.height * 0.025,
                                backgroundColor: isDark! ? cerulian : flame,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.removeCategoryImage();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: platinum,
                                    size: size.height * 0.03,
                                  ),
                                ),
                              ),
                            )),
                      ]),
                    if (cubit.recipeImage != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    GestureDetector(
                      onTap: () {
                        cubit.getrecipeImagefromGallery(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: isDark! ? cerulian : flame, width: 2),
                        ),
                        child: Center(
                            child: Text(
                          'Add +',
                          style: theme.bodyLarge!.copyWith(
                              color: isDark! ? cerulian : flame, fontSize: 20),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    IngredientListWidget(
                      ingredients: ingredients,
                      onIngredientsChanged: (newIngredients) {
                        setState(() {
                          ingredients = newIngredients;
                        });
                      },
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate() && cubit.pickedFile != null) {
              cubit.addRecipe(
                  ingredients: ingredients,
                  name: nameController.text,
                  prepTime: int.parse(prepTimeController.text),
                  calories: int.parse(caloriesController.text),
                  description: descriptionController.text,
                  category: widget.categoryId,
                  subcategory: widget.subCategoryId,
                  vegeterien: isvegeterian,
                  isdiet: isDiet);
            }
          },
          child: Container(
            height: size.height * 0.1,
            color: isDark! ? cerulian : flame,
            child: Center(
                child: state is AddRecipeLoadingState
                    ? CircularProgressIndicator(
                        color: platinum,
                      )
                    : Text("Add", style: theme.displayLarge)),
          ),
        ),
      ),
    );
  }
}
