import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTaskButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(AppLocalizations.of(context)!.addNewTask,),
      ),
    );
  }
}