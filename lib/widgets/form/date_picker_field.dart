import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DatePickerField extends HookWidget {
  const DatePickerField({
    super.key,
    this.initialDate,
    this.selectedDate,
    this.onDateChanged,
    this.firstDate,
    this.lastDate,
    this.labelText,
    this.validator,
    this.autovalidateMode,
  });
  final DateTime? initialDate;
  final DateTime? selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime?)? onDateChanged;
  final String? labelText;
  final String? Function(DateTime?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final pickedDate = useState(selectedDate ?? initialDate);
    final errorText = useState<String?>(null);

    final firstDateValue = firstDate ?? DateTime(2000);
    final lastDateValue = lastDate ?? DateTime.now().add(const Duration(days: 365 * 10));

    useEffect(() {
      if (selectedDate != null) {
        pickedDate.value = selectedDate;
      }
      return null;
    }, [selectedDate]);

    useEffect(() {
      if (validator != null) {
        errorText.value = validator!(pickedDate.value);
      }
      return null;
    }, [pickedDate.value]);

    return FormField<DateTime>(
      initialValue: initialDate,
      validator: validator != null ? (value) => validator!(value) : null,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      onSaved: (newValue) {
        if (newValue != null && onDateChanged != null) {
          onDateChanged!(newValue);
        }
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (labelText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  labelText!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            GestureDetector(
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
                field.didChange(picked);

                if (onDateChanged != null) {
                  onDateChanged!(pickedDate.value!);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                  border: field.hasError
                      ? Border.all(color: Theme.of(context).colorScheme.error, width: 1.5)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pickedDate.value == null
                          ? '請選擇日期'
                          : DateFormat('yyyy/MM/dd').format(pickedDate.value!),
                      style: TextStyle(
                        fontSize: 16,
                        color: pickedDate.value == null ? Colors.grey : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (pickedDate.value != null) {
                          pickedDate.value = null;
                          field.didChange(null);
                          onDateChanged?.call(null);
                        }
                      },
                      child: Icon(
                        pickedDate.value == null ? Icons.calendar_today : Icons.close,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 12),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
