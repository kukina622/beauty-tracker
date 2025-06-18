import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/widgets/category/category_selector/category_selector_item.dart';
import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:flutter/material.dart';

class CategorySelectionSheet extends StatefulWidget {
  const CategorySelectionSheet({
    super.key,
    required this.allCategories,
    required this.initialSelectedIds,
    required this.onConfirmed,
  });

  final List<Category> allCategories;
  final List<String> initialSelectedIds;
  final ValueChanged<List<String>> onConfirmed;

  /// 建議用這個靜態方法呼叫，使用者端就不需知道 bottom-sheet 細節
  static Future<void> show(
    BuildContext context, {
    required List<Category> allCategories,
    required List<String> initialSelectedIds,
    required ValueChanged<List<String>> onConfirmed,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CategorySelectionSheet(
        allCategories: allCategories,
        initialSelectedIds: initialSelectedIds,
        onConfirmed: onConfirmed,
      ),
    );
  }

  @override
  State<CategorySelectionSheet> createState() => _CategorySelectionSheetState();
}

class _CategorySelectionSheetState extends State<CategorySelectionSheet> {
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List<String>.from(widget.initialSelectedIds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('選擇類別', style: Theme.of(context).textTheme.titleLarge),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => setState(_selectedIds.clear),
                      child: const Text('清除全部'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                ...widget.allCategories.map(
                  (c) => CategorySelectorItem(
                    category: c,
                    isSelected: _selectedIds.contains(c.id),
                    onSelected: () => setState(() {
                      _selectedIds.contains(c.id)
                          ? _selectedIds.remove(c.id)
                          : _selectedIds.add(c.id);
                    }),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: AppElevatedButton(
              height: 56,
              text: '確定',
              isFilled: true,
              onPressed: () {
                widget.onConfirmed(_selectedIds);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
