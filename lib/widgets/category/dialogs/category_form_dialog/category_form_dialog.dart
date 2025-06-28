import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/requests/category_requests/create_category_request.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:beauty_tracker/util/extensions/color.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/color_selector_field.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/icon_selector_field.dart';
import 'package:beauty_tracker/widgets/common/dialog/app_dialog.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryFormDialog extends HookWidget {
  const CategoryFormDialog({super.key, this.onCategoryCreated});
  final void Function(Category)? onCategoryCreated;

  static Future<void> show(BuildContext context, {void Function(Category)? onCategoryCreated}) {
    return showDialog<void>(
      context: context,
      builder: (_) => CategoryFormDialog(
        onCategoryCreated: onCategoryCreated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryService = useDi<CategoryService>();

    final categoryNameController = useTextEditingController();
    final categoryIcon = useState<IconData?>(null);
    final categoryColor = useState<Color?>(null);

    Future<void> onConfirm() async {
      final name = categoryNameController.text.trim();
      final icon = categoryIcon.value;
      final color = categoryColor.value;

      if (name.isEmpty || icon == null || color == null) {
        EasyLoading.showError('請填寫所有欄位', maskType: EasyLoadingMaskType.black);
        return;
      }

      final newCategory = CreateCategoryRequest(
        categoryName: name,
        categoryIcon: icon.codePoint,
        categoryColor: color.toInt(),
      );

      final result = await categoryService.createNewCategory(newCategory);
      switch (result) {
        case Ok(value: final Category category):
          EasyLoading.showSuccess('類別新增成功', maskType: EasyLoadingMaskType.black);
          onCategoryCreated?.call(category);

          if (context.mounted && AutoRouter.of(context).canPop()) {
            AutoRouter.of(context).pop();
          }
          break;
        case Err():
          EasyLoading.showError('新增失敗', maskType: EasyLoadingMaskType.black);
          break;
      }
    }

    return StatefulBuilder(
      builder: (context, setModalState) => AppDialog(
        title: '新增類別',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            BaseFormField(
              labelText: '類別名稱',
              controller: categoryNameController,
            ),
            const SizedBox(height: 20),
            Text(
              '選擇圖示',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            IconSelectorField(
              initialIcon: Icons.face,
              onSelect: (icon) {
                setModalState(() {
                  categoryIcon.value = icon;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              '選擇顏色',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ColorSelectorField(
              initialColor: Color(0xFFFF9A9E),
              onSelect: (color) {
                setModalState(() {
                  categoryColor.value = color;
                });
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
        onConfirm: onConfirm,
      ),
    );
  }
}
