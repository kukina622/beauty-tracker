import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/category.dart';

abstract class CategoryService {
  Future<Result<void>> createNewCategory(Category category);
}
