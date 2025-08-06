import 'package:auto_route/auto_route.dart';
import 'package:beauty_tracker/router/router.gr.dart';
import 'package:beauty_tracker/widgets/common/icon_button/app_filled_icon_button.dart';
import 'package:beauty_tracker/widgets/product/product_selection_sheet.dart';
import 'package:flutter/material.dart';

class CopyProductButton extends StatelessWidget {
  const CopyProductButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFilledIconButton(
      icon: Icons.copy_all_outlined,
      iconColor: const Color(0xFF2D3142),
      backgroundColor: Colors.white,
      size: 44.0,
      borderRadius: BorderRadius.circular(12),
      onPressed: () async {
        final selectedProduct = await ProductSelectionSheet.show(context);

        if (selectedProduct == null || !context.mounted) {
          return;
        }

        final currentRoute = AutoRouter.of(context).current;

        if (currentRoute.path == '/product/add') {
          AutoRouter.of(context).replace(
            AddProductRoute(productToCopy: selectedProduct),
          );
        } else {
          AutoRouter.of(context).push(
            AddProductRoute(productToCopy: selectedProduct),
          );
        }
      },
    );
  }
}
