import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/hooks/use_easy_loading.dart';
import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/requests/brand_requests/create_brand_request.dart';
import 'package:beauty_tracker/requests/brand_requests/update_brand_request.dart';
import 'package:beauty_tracker/services/brand_service/brand_service.dart';
import 'package:beauty_tracker/widgets/common/dialog/app_dialog.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BrandFormDialog extends HookWidget {
  const BrandFormDialog({
    super.key,
    this.onBrandCreated,
    this.onBrandUpdated,
    this.brandToEdit,
  });
  final void Function(Brand)? onBrandCreated;
  final void Function(Brand)? onBrandUpdated;
  final Brand? brandToEdit;

  static Future<void> showCreate(BuildContext context, {void Function(Brand)? onBrandCreated}) {
    return showDialog<void>(
      context: context,
      builder: (_) => BrandFormDialog(
        onBrandCreated: onBrandCreated,
      ),
    );
  }

  static Future<void> showEdit(
    BuildContext context, {
    required Brand brand,
    void Function(Brand)? onBrandUpdated,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => BrandFormDialog(
        brandToEdit: brand,
        onBrandUpdated: onBrandUpdated,
      ),
    );
  }

  bool get isEditing => brandToEdit != null;

  @override
  Widget build(BuildContext context) {
    final brandService = useDi<BrandService>();
    final easyLoading = useEasyLoading();

    final brandNameController = useTextEditingController(
      text: brandToEdit?.brandName ?? '',
    );

    Future<void> onConfirm() async {
      final name = brandNameController.text.trim();
      easyLoading.show(status: '處理中...');
      if (name.isEmpty) {
        easyLoading.showError('請填寫所有欄位');
        return;
      }

      if (isEditing) {
        // 更新品牌
        final result = await brandService.updateBrand(
          brandToEdit!.id,
          UpdateBrandRequest(brandName: name),
        );
        switch (result) {
          case Ok(value: final Brand brand):
            easyLoading.showSuccess('品牌更新成功');
            onBrandUpdated?.call(brand);
            if (context.mounted && AutoRouter.of(context).canPop()) {
              AutoRouter.of(context).pop();
            }
            break;
          case Err():
            easyLoading.showError('品牌更新失敗');
            break;
        }
      } else {
        final newBrand = CreateBrandRequest(brandName: name);
        final result = await brandService.createNewBrand(newBrand);
        switch (result) {
          case Ok(value: final Brand brand):
            easyLoading.showSuccess('品牌新增成功');
            onBrandCreated?.call(brand);
            if (context.mounted && AutoRouter.of(context).canPop()) {
              AutoRouter.of(context).pop();
            }
            break;
          case Err():
            easyLoading.showError('品牌新增失敗');
            break;
        }
      }
    }

    return StatefulBuilder(
      builder: (context, setModalState) => AppDialog(
        title: isEditing ? '編輯品牌' : '新增品牌',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            BaseFormField(
              labelText: '品牌名稱',
              controller: brandNameController,
            ),
            const SizedBox(height: 10),
          ],
        ),
        onConfirm: onConfirm,
      ),
    );
  }
}
