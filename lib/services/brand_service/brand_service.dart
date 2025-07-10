import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/brand.dart';

abstract class BrandService {
  Future<Result<List<Brand>>> getAllBrands();
}
