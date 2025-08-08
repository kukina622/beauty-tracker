import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/requests/category_requests/create_category_request.dart';
import 'package:beauty_tracker/requests/category_requests/update_category_request.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCategoryServiceImpl implements CategoryService {
  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<Result<List<Category>>> getAllCategories() {
    return resultGuard(() async {
      final fetchedCategoryData =
          await supabase.from('categories').select().order('category_name', ascending: true);
      return fetchedCategoryData.map((e) => Category.fromJson(e)).toList();
    });
  }

  @override
  Future<Result<Category>> createNewCategory(CreateCategoryRequest category) async {
    return resultGuard(() async {
      final insertedCategory = await supabase.from('categories').upsert(category.toJson()).select();
      if (insertedCategory.isEmpty) {
        throw Exception('Failed to insert category');
      }
      return Category.fromJson(insertedCategory.first);
    });
  }

  @override
  Future<Result<Category>> updateCategory(String categoryId, UpdateCategoryRequest category) {
    return resultGuard(() async {
      final updatedCategory = await supabase
          .from('categories')
          .update(category.toJson())
          .eq('id', categoryId)
          .select()
          .single();

      return Category.fromJson(updatedCategory);
    });
  }

  @override
  Future<Result<void>> deleteCategory(String categoryId) {
    return resultGuard(() async {
      await supabase.from('product_category').delete().eq('category_id', categoryId);
      await supabase.from('categories').delete().eq('id', categoryId);
    });
  }
}
