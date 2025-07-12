import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/errors/result.dart';
import 'package:beauty_tracker/hooks/use_di.dart';
import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/requests/category_requests/create_category_request.dart';
import 'package:beauty_tracker/requests/category_requests/update_category_request.dart';
import 'package:beauty_tracker/services/category_service/category_service.dart';
import 'package:beauty_tracker/util/extensions/color.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/color_selector_field.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/icon_selector_field.dart';
import 'package:beauty_tracker/widgets/common/dialog/app_dialog.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryFormDialog extends HookWidget {
  const CategoryFormDialog({
    super.key,
    this.onCategoryCreated,
    this.onCategoryUpdated,
    this.categoryToEdit,
  });
  final void Function(Category)? onCategoryCreated;
  final void Function(Category)? onCategoryUpdated;
  final Category? categoryToEdit;

  static Future<void> showCreate(
    BuildContext context, {
    void Function(Category)? onCategoryCreated,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => CategoryFormDialog(
        onCategoryCreated: onCategoryCreated,
      ),
    );
  }

  static Future<void> showEdit(
    BuildContext context, {
    required Category category,
    void Function(Category)? onCategoryUpdated,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => CategoryFormDialog(
        categoryToEdit: category,
        onCategoryUpdated: onCategoryUpdated,
      ),
    );
  }

  bool get isEditing => categoryToEdit != null;

  @override
  Widget build(BuildContext context) {
    final categoryService = useDi<CategoryService>();

    final categoryNameController = useTextEditingController(
      text: categoryToEdit?.categoryName ?? '',
    );

    final categoryIcon = useState<IconData?>(
      categoryToEdit != null ? getAppIcon(categoryToEdit!.categoryIcon) : null,
    );

    final categoryColor = useState<Color?>(
      categoryToEdit != null ? Color(categoryToEdit!.categoryColor) : null,
    );

    Future<void> onConfirm() async {
      final name = categoryNameController.text.trim();
      final icon = categoryIcon.value;
      final color = categoryColor.value;

      if (name.isEmpty || icon == null || color == null) {
        EasyLoading.showError('請填寫所有欄位', maskType: EasyLoadingMaskType.black);
        return;
      }

      EasyLoading.show(status: '處理中...', maskType: EasyLoadingMaskType.black);

      if (isEditing) {
        final updateRequest = UpdateCategoryRequest(
          categoryName: name,
          categoryIcon: icon.codePoint,
          categoryColor: color.toInt(),
        );
        final result = await categoryService.updateCategory(categoryToEdit!.id, updateRequest);

        switch (result) {
          case Ok(value: final Category category):
            EasyLoading.showSuccess('類別更新成功', maskType: EasyLoadingMaskType.black);
            onCategoryUpdated?.call(category);
            if (context.mounted && AutoRouter.of(context).canPop()) {
              AutoRouter.of(context).pop();
            }
            break;
          case Err():
            EasyLoading.showError('類別更新失敗', maskType: EasyLoadingMaskType.black);
            break;
        }
      } else {
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
    }

    return StatefulBuilder(
      builder: (context, setModalState) => AppDialog(
        title: isEditing ? '編輯類別' : '新增類別',
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
              initialIcon: categoryIcon.value,
              isEditing: isEditing,
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
              initialColor: categoryColor.value,
              isEditing: isEditing,
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
