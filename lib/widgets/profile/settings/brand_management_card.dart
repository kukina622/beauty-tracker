import 'package:beauty_tracker/models/brand.dart';
import 'package:beauty_tracker/widgets/common/icon_button/app_standard_icon_button.dart';
import 'package:flutter/material.dart';

class BrandManagementCard extends StatelessWidget {
  const BrandManagementCard({
    super.key,
    required this.brand,
    this.onEdit,
    this.onDelete,
  });

  final Brand brand;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    final String brandName = brand.brandName;

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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              brandName.isNotEmpty ? brandName[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        title: Text(
          brandName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
        trailing: SizedBox(
          width: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppStandardIconButton(
                icon: Icons.edit,
                onPressed: onEdit,
                iconColor: const Color(0xFF5ECCC4),
                size: 20,
              ),
              const SizedBox(width: 8),
              AppStandardIconButton(
                icon: Icons.delete_outline,
                onPressed: onDelete,
                iconColor: const Color(0xFFFF6B6B),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
