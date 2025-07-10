import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/errors/result_guard.dart';
import 'package:beauty_tracker/models/brand.dart';
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
}
