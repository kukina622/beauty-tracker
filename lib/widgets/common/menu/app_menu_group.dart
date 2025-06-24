import 'package:beauty_tracker/widgets/common/menu/app_menu_item.dart';
import 'package:flutter/material.dart';

class AppMenuGroup extends StatelessWidget {
  const AppMenuGroup({super.key, this.items = const []});
  final List<AppMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            if (index < items.length - 1) {
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    clipBehavior: Clip.hardEdge,
                    child: item,
                  ),
                  const Divider(height: 1),
                ],
              );
            }

            return Material(
              color: Colors.transparent,
              child: item,
            );
          }).toList(),
        ),
      ),
    );
  }
}
