import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DatePickerField extends HookWidget {
  const DatePickerField({
    super.key,
    this.initialDate,
    this.onDateChanged,
    this.firstDate,
    this.lastDate,
  });
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime)? onDateChanged;

  @override
  Widget build(BuildContext context) {
    final pickedDate = useState(initialDate);

    final firstDateValue = firstDate ?? DateTime(2000);
    final lastDateValue = lastDate ?? DateTime.now().add(const Duration(days: 365 * 10));

    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          helpText: '選擇日期',
          cancelText: '取消',
          confirmText: '確定',
          fieldLabelText: '選擇日期',
          fieldHintText: '請選擇日期',
          initialDate: pickedDate.value ?? DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          firstDate: firstDateValue,
          lastDate: lastDateValue,
        );

        if (picked == null) {
          return;
        }

        pickedDate.value = picked;

        if (onDateChanged != null) {
          onDateChanged!(pickedDate.value!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pickedDate.value == null
                  ? '請選擇日期'
                  : DateFormat('yyyy/MM/d').format(pickedDate.value!),
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.calendar_today, color: Color(0xFF2D3142)),
          ],
        ),
      ),
    );
  }
}
