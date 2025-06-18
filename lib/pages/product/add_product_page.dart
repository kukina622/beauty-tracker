import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selector.dart';
import 'package:beauty_tracker/widgets/common/app_card.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/form/base_form_field.dart';
import 'package:beauty_tracker/widgets/page/page_scroll_view.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新增保養品'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => AutoRouter.of(context).pop(),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: PageScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppCard(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '保養品細項',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 24),
                        BaseFormField(
                          labelText: '產品名稱',
                          hintText: '輸入產品名稱',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '請輸入產品名稱';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        BaseFormField(
                          labelText: '品牌(可選)',
                          hintText: '輸入品牌名稱',
                        ),
                        const SizedBox(height: 16),
                        BaseFormField(
                          labelText: '價格',
                          hintText: '輸入價格',
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '類別',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        CategorySelector()
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  AppElevatedButton(
                    text: '新增保養品',
                    onPressed: () {
                      final bool isFormValid = _formKey.currentState?.validate() ?? false;
                      if (isFormValid) {}
                    },
                    isFilled: true,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
