import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/color_selector_field.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/icon_selector_field.dart';
import 'package:beauty_tracker/widgets/common/dialog/app_dialog.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CategoryFormDialog extends HookWidget {
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => CategoryFormDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            const SizedBox(height: 20),
            Text(
              '選擇圖示',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            IconSelectorField(),
            const SizedBox(height: 20),
            Text(
              '選擇顏色',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            ColorSelectorField(),
            const SizedBox(height: 10),
          ],
        ),
        onConfirm: () {},
      ),
    );
  }
}
