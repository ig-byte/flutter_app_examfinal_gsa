import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/models/models.dart';
import 'package:flutter_app_examfinal_gsa/services/services.dart';
import 'package:flutter_app_examfinal_gsa/widgets/widgets.dart';
import 'package:flutter_app_examfinal_gsa/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Listado de categoria'),
      ),
      body: ListView.builder(
        itemCount: categoryService.category.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            categoryService.SelectCategoria =
                categoryService.category[index].copy();
            Navigator.pushNamed(context, 'edit_category');
          },
          child: CategoryCard(category: categoryService.category[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoryService.SelectCategoria = Listado_cat(
              CategoryId: 0, CategoryName: '', CategoryState: 'Activo');
          Navigator.pushNamed(context, 'edit_category');
        },
      ),
    );
  }
}
