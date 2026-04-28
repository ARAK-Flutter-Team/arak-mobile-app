import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTaskButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    print('ADD TASK BUTTON BUILD ');
    print('AddTaskButton - onPressed exists: ${onPressed != null}');

    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth - 32;

    print('Screen width: $screenWidth, Button width: $buttonWidth');

    return SizedBox(
      width: buttonWidth,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          print('ADD TASK BUTTON PRESSED');
          print('Timestamp: ${DateTime.now()}');
          print('onPressed callback exists: ${onPressed != null}');

          if (onPressed == null) {
            print(' ERROR: onPressed is NULL!');
            return;
          }

          print(' Calling onPressed()...');

          try {
            onPressed();
            print(' onPressed() executed successfully');
          } catch (e) {
            print(' ERROR in onPressed: $e');
            print(' Stack trace: ${StackTrace.current}');
          }

          print(' Navigation completed');
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.addNewTask,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}