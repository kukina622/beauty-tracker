import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/color_selector_field.dart';
import 'package:beauty_tracker/widgets/category/dialogs/category_form_dialog/icon_selector_field.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/common/button/app_outlined_button.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:flutter/material.dart';

class CategoryFormDialog extends StatefulWidget {
  const CategoryFormDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const CategoryFormDialog(),
    );
  }

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  '新增類別',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
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
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {},
                    text: '取消',
                    height: 48,
                    borderColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppElevatedButton(
                    onPressed: () {},
                    text: '確認',
                    height: 48,
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
