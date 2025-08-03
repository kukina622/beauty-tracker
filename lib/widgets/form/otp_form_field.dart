import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OtpFormField extends HookWidget {
  const OtpFormField({
    super.key,
    required this.onChanged,
    this.validator,
    this.length = 6,
  });

  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final int length;

  @override
  Widget build(BuildContext context) {
    final controllers = List.generate(length, (index) => useTextEditingController());
    final focusNodes = List.generate(length, (index) => useFocusNode());
    final otpValue = useState('');

    useEffect(() {
      void updateOtpValue() {
        final otp = controllers.map((final controller) => controller.text).join();
        otpValue.value = otp;
        onChanged(otp);
      }

      for (final controller in controllers) {
        controller.addListener(updateOtpValue);
      }

      return () {
        for (final controller in controllers) {
          controller.removeListener(updateOtpValue);
        }
      };
    }, [controllers]);

    return FormField<String>(
      validator: (value) => validator?.call(otpValue.value),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(length, (index) {
                return SizedBox(
                  width: 50,
                  child: TextFormField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (index < length - 1) {
                          focusNodes[index + 1].requestFocus();
                        } else {
                          focusNodes[index].unfocus();
                        }
                      } else if (value.isEmpty && index > 0) {
                        focusNodes[index - 1].requestFocus();
                      }
                    },
                    onTap: () {
                      controllers[index].selection = TextSelection.fromPosition(
                        TextPosition(offset: controllers[index].text.length),
                      );
                    },
                  ),
                );
              }),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  field.errorText!,
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
