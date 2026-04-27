import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/student_provider.dart';
import '../widgets/student_card.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final filteredStudents = ref.watch(filteredStudentsProvider);
    final isLoading = ref.watch(studentListProvider).isLoading;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppMainAppBar(
        title: l10n.searchStudent, // ✅
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, size: 20.sp),
            onPressed: () => ref.read(studentListProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            TextField(
              onChanged: (val) =>
                  ref.read(searchQueryProvider.notifier).state = val,
              decoration: InputDecoration(
                labelText: l10n.searchByName, // ✅
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredStudents.isEmpty
                      ? Center(child: Text(l10n.noStudentFound)) // ✅
                      : ListView.builder(
                          itemCount: filteredStudents.length,
                          itemBuilder: (context, index) {
                            return StudentCard(
                              student: filteredStudents[index],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
