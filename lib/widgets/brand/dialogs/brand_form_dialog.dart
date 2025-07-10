import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/requests/brand_requests/create_brand_request.dart';
import 'package:beauty_tracker/services/brand_service/brand_service.dart';
import 'package:beauty_tracker/widgets/common/dialog/app_dialog.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BrandFormDialog extends HookWidget {
  const BrandFormDialog({super.key, this.onBrandCreated});
  final void Function(Brand)? onBrandCreated;

  static Future<void> show(BuildContext context, {void Function(Brand)? onBrandCreated}) {
    return showDialog<void>(
      context: context,
      builder: (_) => BrandFormDialog(
        onBrandCreated: onBrandCreated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brandService = useDi<BrandService>();

    final brandNameController = useTextEditingController();

    Future<void> onConfirm() async {
      final name = brandNameController.text.trim();

      if (name.isEmpty) {
        EasyLoading.showError('請填寫所有欄位', maskType: EasyLoadingMaskType.black);
        return;
      }

      final newBrand = CreateBrandRequest(brandName: name);
      final result = await brandService.createNewBrand(newBrand);
      switch (result) {
        case Ok(value: final Brand brand):
          EasyLoading.showSuccess('品牌新增成功', maskType: EasyLoadingMaskType.black);
          onBrandCreated?.call(brand);
          if (context.mounted && AutoRouter.of(context).canPop()) {
            AutoRouter.of(context).pop();
          }
          break;
        case Err():
          EasyLoading.showError('品牌新增失敗', maskType: EasyLoadingMaskType.black);
          break;
      }
    }

    return StatefulBuilder(
      builder: (context, setModalState) => AppDialog(
        title: '新增品牌',
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
