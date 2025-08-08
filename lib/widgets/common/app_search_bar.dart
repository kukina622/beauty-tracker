import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppSearchBar extends HookWidget {
  const AppSearchBar({super.key, this.hintText, this.controller, this.onChanged});

  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final searchQuery = useState<String>('');
    final internalController = useTextEditingController();
    final activeController = controller ?? internalController;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: activeController,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 16,
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.search_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
          suffixIcon: searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: Colors.grey.shade400,
                  ),
                  onPressed: () {
                    activeController.clear();
                    searchQuery.value = '';
                    onChanged?.call('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF2D3142),
        ),
        onChanged: (value) {
          searchQuery.value = value;
          onChanged?.call(value);
        },
      ),
    );
  }
}
