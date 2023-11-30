// ignore_for_file: use_key_in_widget_constructors, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forkified/main.dart';
import 'package:forkified/models/categories.model.dart';
import 'package:forkified/models/sub_category.dart';
import 'package:forkified/shared/colors.dart';
import 'package:forkified/shared/components.dart';
import 'package:forkified/shared/cubit/categories/categories_cubit.dart';
import 'package:forkified/shared/cubit/subcategory/subcategory_cubit.dart';

class UpdateSubCategory extends StatefulWidget {
  final SubCategory subCategory;
  const UpdateSubCategory({super.key, required this.subCategory});
  @override
  State<UpdateSubCategory> createState() => _UpdateSubCategoryState();
}

class _UpdateSubCategoryState extends State<UpdateSubCategory> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var descriptionController = TextEditingController();
  List<DropdownMenuItem<CategoryModel>>? items = [];
  CategoryModel? selectedCategory;
  @override
  void initState() {
    nameController.text = widget.subCategory.name.toString();
    descriptionController.text = widget.subCategory.description.toString();
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
        if (state is UpdateSubCategorySuccessState ||
            state is DeleteSubCategorySuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Update ${widget.subCategory.name}",
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
                                "Are you sure you want to delete ${widget.subCategory.name} ?}",
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
                                      cubit.deleteSubCategory(
                                          subcategoryId:
                                              widget.subCategory.id!);
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
                cubit.updateSubCategory(
                    name: nameController.text,
                    description: descriptionController.text,
                    categoryId: selectedCategory!.id.toString(),
                    subcategoryId: widget.subCategory.id.toString());
              }
            },
            child: Container(
              height: size.height * 0.1,
              color: isDark! ? cerulian : flame,
              child: Center(
                  child: state is UpdateSubCategoryLoadingState
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
