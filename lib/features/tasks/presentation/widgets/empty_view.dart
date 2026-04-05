import 'package:flutter/cupertino.dart';

import '../../../../l10n/app_localizations.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocalizations.of(context)!.noTasksFound));
  }
}