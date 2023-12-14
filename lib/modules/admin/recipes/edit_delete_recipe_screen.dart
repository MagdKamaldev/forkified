import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/recipe_model.dart';
import 'package:forkified/modules/admin/recipes/ingredients_widget.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/recipes/recipe_cubit.dart';
import 'package:forkified/shared/networks/remote/dio_helper.dart';
import 'package:lottie/lottie.dart';

class EditDeleteRecipe extends StatefulWidget {
  final String categoryId;
  final String subCategoryId;
  final RecipeModel recipe;
  const EditDeleteRecipe(
      {super.key,
      required this.categoryId,
      required this.subCategoryId,
      required this.recipe});

  @override
  State<EditDeleteRecipe> createState() => _EditDeleteRecipeState();
}

class _EditDeleteRecipeState extends State<EditDeleteRecipe> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var prepTimeController = TextEditingController();

  var caolriesController = TextEditingController();

  var descriptionController = TextEditingController();

  bool isVegeterian = false;

  bool isDiet = false;

  List<dynamic> ingredients = [];

  @override
  void initState() {
    nameController.text = widget.recipe.name!;
    descriptionController.text = widget.recipe.description!;
    prepTimeController.text = widget.recipe.prepTime.toString();
    caolriesController.text = widget.recipe.calories.toString();
    ingredients = widget.recipe.ingredients!;
    isDiet = widget.recipe.diet == "yes" ? true : false;
    isVegeterian = widget.recipe.vegetarian!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = RecipeCubit.get(context);
    return BlocConsumer<RecipeCubit, RecipeCubitState>(
      listener: (context, state) {
        if (state is UpdateRecipeSuccessState ||
            state is DeleteRecipeSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Update Recipe",
              style: theme.displayLarge,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Row(
                                children: [
                                  Text("Delete ",
                                      style: theme.displayLarge!.copyWith(
                                          color: isDark! ? cerulian : flame)),
                                  SizedBox(
                                    width: size.width * 0.05,
                                  ),
                                  Icon(
                                    Icons.warning,
                                    color: isDark! ? cerulian : flame,
                                  )
                                ],
                              ),
                              content: Text(
                                "Are you sure you want to delete ${widget.recipe.name} ?}",
                                style: theme.bodyLarge!
                                    .copyWith(color: prussianBlue),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                        style: theme.displayMedium!.copyWith(
                                            color:
                                                isDark! ? cerulian : flame))),
                                TextButton(
                                    onPressed: () {
                                      cubit.deleteRecipe(id: widget.recipe.id!);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Delete",
                                        style: theme.displayMedium!.copyWith(
                                            color:
                                                isDark! ? cerulian : flame))),
                              ],
                            ));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: platinum,
                  ))
            ],
            toolbarHeight: size.height * 0.08,
          ),
          body: ConditionalBuilder(
            condition: state is! GetRecipeLoading,
            fallback: (context) => Scaffold(
              body: Center(
                  child: Lottie.asset(isDark!
                      ? "assets/animations/forkified loading.json"
                      : "assets/animations/forkified loading orange.json")),
            ),
            builder: (context) {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
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
                          height: size.height * 0.05,
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
                          height: size.height * 0.06,
                        ),
                        defaultFormField(
                          size: size,
                            controller: caolriesController,
                            type: TextInputType.number,
                            onSubmit: () {},
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "caolries must not be empty";
                              }
                            },
                            label: "Recipe calories",
                            prefix: Icons.description,
                            context: context),
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        defaultFormField(
                          size: size,
                            controller: prepTimeController,
                            type: TextInputType.number,
                            onSubmit: () {},
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "prep time must not be empty";
                              }
                            },
                            label: "Recipe prep time (munnites)",
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
                                value: isVegeterian,
                                onChanged: (value) {
                                  setState(() {
                                    isVegeterian = value;
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
                          height: size.height * 0.06,
                        ),
                        Text(
                          "Image",
                          style: theme.displayLarge!
                              .copyWith(color: isDark! ? cerulian : flame),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        if (cubit.updateImage == null && !cubit.imageRemoved)
                          Stack(children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isDark! ? cerulian : flame,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: size.width * 0.9,
                                height: size.height * 0.3,
                                child: Image.network(
                                  "$serverIp${widget.recipe.image!}",
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Container(
                                        width: size.width * 0.35,
                                        height: size.height * 0.1,
                                        color:
                                            isDark! ? prussianBlue : platinum,
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
                                        cubit.removenetworkImage();
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
                        if (cubit.updateImage != null)
                          Stack(children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isDark! ? cerulian : flame,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: size.width * 0.9,
                                height: size.height * 0.3,
                                child: Image.file(
                                  cubit.updateImage!,
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Container(
                                        width: size.width * 0.35,
                                        height: size.height * 0.1,
                                        color:
                                            isDark! ? prussianBlue : platinum,
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
                                        cubit.removeUpdateImage();
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            cubit.getUpdateImagefromGallery(context);
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
                                'Add New +',
                                style: theme.bodyLarge!.copyWith(
                                    color: isDark! ? cerulian : flame,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        IngredientListWidget(
                          ingredients: ingredients,
                          onIngredientsChanged: (newIngredients) {
                            setState(() {
                              ingredients = newIngredients;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                cubit.updateRecipe(
                    id: widget.recipe.id!,
                    name: nameController.text,
                    description: descriptionController.text,
                    prepTime: int.parse(prepTimeController.text),
                    calories: int.parse(caolriesController.text),
                    ingredients: ingredients,
                    isDiet: isDiet,
                    isvegan: isVegeterian);
              }
            },
            child: Container(
              height: size.height * 0.1,
              color: isDark! ? cerulian : flame,
              child: Center(
                  child: state is UpdateRecipeLoadingState
                      ? CircularProgressIndicator(
                          color: platinum,
                        )
                      : Text("Update", style: theme.displayLarge)),
            ),
          ),
        );
      },
    );
  }
}
