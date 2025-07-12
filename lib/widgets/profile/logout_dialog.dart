import 'package:beauty_tracker/widgets/common/dialog/app_dialog.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    this.title = '登出確認',
    this.description,
    required this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String? description;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  static Future<void> show(
    BuildContext context, {
    required String title,
    String? description,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => LogoutDialog(
        title: title,
        description: description,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B).withValues(alpha: .2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.logout,
              size: 30,
              color: Color(0xFFFF6B6B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
      onConfirm: onConfirm,
      confirmText: '確定登出',
      onCancel: onCancel ?? () => Navigator.of(context).pop(),
    );
  }
}
