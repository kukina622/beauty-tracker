import 'package:beauty_tracker/widgets/common/button/app_elevated_button.dart';
import 'package:beauty_tracker/widgets/common/button/app_outlined_button.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = '確認',
    this.cancelText = '取消',
    this.onConfirm,
    this.onCancel,
    this.showConfirm = true,
    this.showCancel = true,
  });
  final String title;
  final Widget content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool showConfirm;
  final bool showCancel;

  Widget _buildButtons(BuildContext context) {
    final buttons = <Widget>[];

    if (showCancel) {
      buttons.add(
        Expanded(
          child: AppOutlinedButton(
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            text: cancelText,
            height: 48,
            borderColor: Colors.grey.shade300,
          ),
        ),
      );
    }

    if (showCancel && showConfirm) {
      buttons.add(const SizedBox(width: 16));
    }

    if (showConfirm) {
      buttons.add(
        Expanded(
          child: AppElevatedButton(
            onPressed: onConfirm,
            text: confirmText,
            height: 48,
          ),
        ),
      );
    }

    return Row(children: buttons);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 16),
            content,
            const SizedBox(height: 20),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }
}
