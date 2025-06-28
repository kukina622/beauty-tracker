import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCategoryServiceImpl implements CategoryService {
  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<Result<void>> createNewCategory(Category category) async {
    return resultGuard(() => supabase.from('categories').insert(category.toJson()));
  }
}
