import 'package:beauty_tracker/widgets/common/icon_button/app_filled_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum EditState {
  view,
  edit,
}

class EditModeToggleButton extends HookWidget {
  const EditModeToggleButton({super.key, this.onEditStateChanged, this.onConfirm});

  final void Function(EditState mode)? onEditStateChanged;
  final dynamic Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final editState = useState(EditState.view);
    final icon = editState.value == EditState.view ? Icons.edit_rounded : Icons.check_rounded;
    final iconColor = editState.value == EditState.view ? const Color(0xFF2D3142) : Colors.white;
    final backgroundColor =
        editState.value == EditState.view ? Colors.white : const Color(0xFF5ECCC4);

    return AppFilledIconButton(
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      size: 44.0,
      borderRadius: BorderRadius.circular(12),
      onPressed: () async {
        if (editState.value == EditState.edit) {
          await onConfirm!();
        }

        editState.value = editState.value == EditState.view ? EditState.edit : EditState.view;

        if (onEditStateChanged != null) {
          onEditStateChanged!(editState.value);
        }
      },
    );
  }
}
