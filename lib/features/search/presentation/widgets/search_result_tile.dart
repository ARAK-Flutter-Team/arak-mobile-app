import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/search_result.dart';

class SearchResultTile extends StatelessWidget {

  final SearchResult result;

  const SearchResultTile({
    super.key,
    required this.result,
  });

  IconData _icon() {

    switch (result.type) {

      case SearchType.student:
        return Icons.person;

      case SearchType.task:
        return Icons.assignment;

      case SearchType.message:
        return Icons.message;

      case SearchType.schedule:
        return Icons.schedule;

    }

  }

  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: Icon(_icon()),

      title: Text(result.title),

      subtitle: result.subtitle != null
          ? Text(result.subtitle!)
          : null,

      onTap: () {

        context.push(result.route);

      },

    );

  }
}