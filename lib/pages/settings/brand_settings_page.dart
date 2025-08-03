import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/hooks/use_provider.dart';
import 'package:beauty_tracker/hooks/use_service_data.dart';
import 'package:beauty_tracker/providers/product_provider.dart';
import 'package:beauty_tracker/services/brand_service/brand_service.dart';
import 'package:beauty_tracker/widgets/brand/dialogs/brand_form_dialog.dart';
import 'package:beauty_tracker/widgets/common/app_search_bar.dart';
import 'package:beauty_tracker/widgets/common/app_title_bar.dart';
import 'package:beauty_tracker/widgets/common/dialog/delete_dialog.dart';
import 'package:beauty_tracker/widgets/common/icon_button/app_filled_icon_button.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:beauty_tracker/widgets/profile/settings/brand_management_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class BrandSettingsPage extends HookWidget {
  const BrandSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = useProvider<ProductProvider>();
    final easyLoading = useEasyLoading();

    final brandService = useDi<BrandService>();
    final brandsResult = useServiceData(() => brandService.getAllBrands());
    final brands = brandsResult.data ?? [];

    final searchQuery = useState<String>('');

    final filteredBrands = useMemoized(() {
      if (searchQuery.value.isEmpty) {
        return brands;
      }
      return brands.where((brand) {
        return brand.brandName.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }, [brands, searchQuery.value]);

    final onDeleteBrand = useCallback((String brandId) async {
      easyLoading.show(status: '處理中...');
      final result = await brandService.deleteBrand(brandId).whenComplete(() {
        easyLoading.dismiss();
      });

      switch (result) {
        case Ok():
          easyLoading.showSuccess('品牌刪除成功');
          brandsResult.refresh();
          productProvider.triggerRefresh();
          if (context.mounted && AutoRouter.of(context).canPop()) {
            AutoRouter.of(context).pop();
          }
          break;
        case Err():
          easyLoading.showError('品牌刪除失敗');
          break;
      }
    }, [brandsResult]);

    return Scaffold(
      body: PageScrollView(
        header: [
          AppTitleBar(
            title: '品牌設定',
            actionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppFilledIconButton(
                  icon: Icons.add,
                  iconColor: const Color(0xFF2D3142),
                  backgroundColor: Colors.white,
                  size: 44.0,
                  borderRadius: BorderRadius.circular(12),
                  onPressed: () {
                    BrandFormDialog.showCreate(
                      context,
                      onBrandCreated: (brand) => brandsResult.refresh(),
                    );
                  },
                ),
              ],
            ),
            backButtonEnabled: true,
          )
        ],
        slivers: [
          SliverToBoxAdapter(
            child: AppSearchBar(
              hintText: '搜尋品牌',
              onChanged: (p0) => searchQuery.value = p0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: filteredBrands.length,
              (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: BrandManagementCard(
                    brand: filteredBrands[index],
                    onEdit: () {
                      BrandFormDialog.showEdit(
                        context,
                        brand: filteredBrands[index],
                        onBrandUpdated: (brand) {
                          brandsResult.refresh();
                          productProvider.triggerRefresh();
                        },
                      );
                    },
                    onDelete: () {
                      DeleteDialog.show(
                        context,
                        title: '確認刪除品牌嗎',
                        description: '這個操作無法復原。',
                        onConfirm: () => onDeleteBrand(filteredBrands[index].id),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
