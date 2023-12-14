// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/categories/categories_cubit.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';

class AddSubCategory extends StatefulWidget {
  @override
  State<AddSubCategory> createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var descriptionController = TextEditingController();
  List<DropdownMenuItem<CategoryModel>>? items = [];
  CategoryModel? selectedCategory;
  @override
  void initState() {
    for (CategoryModel categoryitem
        in CategoriesCubit.get(context).categories) {
      items!.add(DropdownMenuItem(
        value: categoryitem,
        child: Text(categoryitem.name!),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme theme = Theme.of(context).textTheme;
    var cubit = SubcategoryCubit.get(context);

    return BlocConsumer<SubcategoryCubit, SubcategoryState>(
      listener: (context, state) {
        if (state is AddSubCategorySuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add Sub Category",
              style: theme.displayLarge,
            ),
            toolbarHeight: size.height * 0.08,
          ),
          body: Form(
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
                        label: "Sub Category Name",
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
                        label: "Sub Category Description",
                        prefix: Icons.description,
                        context: context),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    Text("Category", style: theme.displayMedium!),
                    SizedBox(
                      height: size.height * 0.045,
                    ),
                    DropdownButton<CategoryModel>(
                      style: theme.displayMedium!.copyWith(color: platinum),
                      dropdownColor: isDark! ? cerulian : flame,
                      alignment: Alignment.center,
                      value: selectedCategory,
                      onChanged: (CategoryModel? category) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      items: items,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                cubit.addSubCategory(
                    name: nameController.text,
                    description: descriptionController.text,
                    categoryId: selectedCategory!.id.toString());
              }
            },
            child: Container(
              height: size.height * 0.1,
              color: isDark! ? cerulian : flame,
              child: Center(
                  child: state is AddSubCategoryLoadingState
                      ? CircularProgressIndicator(
                          color: platinum,
                        )
                      : Text("Add", style: theme.displayLarge)),
            ),
          ),
        );
      },
    );
  }
}
