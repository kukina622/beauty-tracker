import 'package:beauty_tracker/models/category.dart';
import 'package:beauty_tracker/util/icon.dart';
import 'package:beauty_tracker/widgets/common/icon_button/app_standard_icon_button.dart';
import 'package:flutter/material.dart';

class CategoryManagementCard extends StatelessWidget {
  const CategoryManagementCard({
    super.key,
    required this.category,
    this.onEdit,
    this.onDelete,
  });
  final Category category;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  Color get categoryColor => Color(category.categoryColor);
  IconData get categoryIcon => getAppIcon(category.categoryIcon);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: categoryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        categoryColor,
                        categoryColor.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: categoryColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    categoryIcon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppStandardIconButton(
                      icon: Icons.edit,
                      onPressed: onEdit,
                      iconColor: const Color(0xFF5ECCC4),
                      size: 20,
                    ),
                    const SizedBox(height: 8),
                    AppStandardIconButton(
                      icon: Icons.delete_outline,
                      onPressed: onDelete,
                      iconColor: const Color(0xFFFF6B6B),
                      size: 20,
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Text(
              category.categoryName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3142),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
