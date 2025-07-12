import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/requests/brand_requests/create_brand_request.dart';
import 'package:beauty_tracker/requests/brand_requests/update_brand_request.dart';
import 'package:beauty_tracker/services/brand_service/brand_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseBrandServiceImpl implements BrandService {
  SupabaseClient get supabase => Supabase.instance.client;

  @override
  Future<Result<List<Brand>>> getAllBrands() {
    return resultGuard(() async {
      final fetchedBrandData = await supabase.from('brands').select();
      return fetchedBrandData.map((e) => Brand.fromJson(e)).toList();
    });
  }

  @override
  Future<Result<Brand>> createNewBrand(CreateBrandRequest brand) {
    return resultGuard(() async {
      final insertedBrand = await supabase.from('brands').upsert(brand.toJson()).select();
      if (insertedBrand.isEmpty) {
        throw Exception('Failed to insert brand');
      }
      return Brand.fromJson(insertedBrand.first);
    });
  }

  @override
  Future<Result<Brand>> updateBrand(String brandId, UpdateBrandRequest brand) {
    return resultGuard(() async {
      final updatedBrand =
          await supabase.from('brands').update(brand.toJson()).eq('id', brandId).select().single();

      return Brand.fromJson(updatedBrand);
    });
  }
}
