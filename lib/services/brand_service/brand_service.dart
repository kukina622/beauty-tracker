import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/requests/brand_requests/create_brand_request.dart';
import 'package:beauty_tracker/requests/brand_requests/update_brand_request.dart';

abstract class BrandService {
  Future<Result<List<Brand>>> getAllBrands();
  Future<Result<Brand>> createNewBrand(CreateBrandRequest brand);
  Future<Result<Brand>> updateBrand(String brandId, UpdateBrandRequest brand);
}
