import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/search_providers.dart';
import '../widgets/search_result_tile.dart';

class TeacherSearchPage extends ConsumerWidget {
  const TeacherSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loc = AppLocalizations.of(context)!;
    final resultsAsync = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppMainAppBar(
        title: loc.search,
        centerTitle: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: loc.searchHint, // 👈 مهم
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: resultsAsync.when(
                data: (results) {
                  if (results.isEmpty) {
                    return Center(
                      child: Text(loc.noResultsFound),
                    );
                  }

                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return SearchResultTile(
                        result: results[index],
                      );
                    },
                  );
                },
                loading: () =>
                const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}