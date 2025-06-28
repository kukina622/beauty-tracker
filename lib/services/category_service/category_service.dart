import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/requests/category_requests/create_category_request.dart';

abstract class CategoryService {
  Future<Result<List<Category>>> getAllCategories();
  Future<Result<Category>> createNewCategory(CreateCategoryRequest category);
}
