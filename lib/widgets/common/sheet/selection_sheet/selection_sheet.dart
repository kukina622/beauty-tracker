import 'package:beauty_tracker/widgets/common/app_search_bar.dart';
import 'package:flutter/material.dart';

class SelectionSheet<T> extends StatefulWidget {
  const SelectionSheet({
    super.key,
    required this.title,
    required this.allItems,
    required this.initialSelectedItems,
    required this.onConfirmed,
    required this.itemBuilder,
    this.isSearchable = false,
    this.bottomActionWidget,
    this.allowMultipleSelection = true,
    this.clearAllText = '清除全部',
    this.confirmText = '確定',
  });

  final String title;
  final bool isSearchable;
  final List<T> allItems;
  final List<T> initialSelectedItems;
  final void Function(List<T>) onConfirmed;
  final Widget Function(T item, bool isSelected, VoidCallback onSelected) itemBuilder;
  final Widget? bottomActionWidget;
  final bool allowMultipleSelection;
  final String clearAllText;
  final String confirmText;

  static Future<void> show<T>(
    BuildContext context, {
    required String title,
    required List<T> allItems,
    required List<T> initialSelectedItems,
    required void Function(List<T>) onConfirmed,
    required Widget Function(T item, bool isSelected, VoidCallback onSelected) itemBuilder,
    bool isSearchable = false,
    Widget? bottomActionWidget,
    bool allowMultipleSelection = true,
    String clearAllText = '清除全部',
    String confirmText = '確定',
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectionSheet<T>(
        title: title,
        allItems: allItems,
        initialSelectedItems: initialSelectedItems,
        isSearchable: isSearchable,
        onConfirmed: onConfirmed,
        itemBuilder: itemBuilder,
        bottomActionWidget: bottomActionWidget,
        allowMultipleSelection: allowMultipleSelection,
        clearAllText: clearAllText,
        confirmText: confirmText,
      ),
    );
  }

  @override
  State<SelectionSheet<T>> createState() => _SelectionSheetState<T>();
}

class _SelectionSheetState<T> extends State<SelectionSheet<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List<T>.from(widget.initialSelectedItems);
  }

  void _toggleSelection(T item) {
    setState(() {
      if (widget.allowMultipleSelection) {
        if (_selectedItems.contains(item)) {
          _selectedItems.remove(item);
        } else {
          _selectedItems.add(item);
        }
      } else {
        _selectedItems = [item];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setModalState) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => setModalState(() {
                          _selectedItems.clear();
                        }),
                        child: Text(widget.clearAllText),
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
            const Divider(height: 32, color: Color.fromARGB(255, 255, 255, 255)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  if (widget.isSearchable) ...[
                    AppSearchBar(
                      hintText: '搜尋...',
                      onChanged: (query) {
                        setModalState(() {
                          // Implement search logic here if needed
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  ...widget.allItems.map(
                    (item) => widget.itemBuilder(
                      item,
                      _selectedItems.contains(item),
                      () => setModalState(() => _toggleSelection(item)),
                    ),
                  ),
                  if (widget.bottomActionWidget != null) ...[
                    const SizedBox(height: 16),
                    widget.bottomActionWidget!,
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setModalState(() {
                      widget.onConfirmed(_selectedItems);
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    widget.confirmText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
