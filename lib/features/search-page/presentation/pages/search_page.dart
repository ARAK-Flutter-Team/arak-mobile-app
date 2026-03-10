<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/student_provider.dart';
import '../widgets/student_card.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredStudents = ref.watch(filteredStudentsProvider);
    final isLoading = ref.watch(studentListProvider).isLoading;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Search Student"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(studentListProvider.notifier).refresh(),
          )
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
                labelText: "Search by name...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredStudents.isEmpty
                      ? const Center(child: Text("No student found"))
                      : ListView.builder(
                          itemCount: filteredStudents.length,
                          itemBuilder: (context, index) {
                            return StudentCard(
                                student: filteredStudents[index]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
=======
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/student_provider.dart';
// import '../widgets/student_card.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Search Student"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => context.read<StudentProvider>().fetchStudents(),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               // onChanged: (val) => context.read<StudentProvider>().searchStudent(val),
//               onChanged: (val) {
//                 // هنستخدم اللي في الـ Provider
//                 Provider.of<StudentProvider>(context, listen: false)
//                     .searchStudent(val);
//               },
//               decoration: InputDecoration(
//                 labelText: "Search by name...",
//                 prefixIcon: const Icon(Icons.search),
//                 border:
//                     OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: Consumer<StudentProvider>(
//                 builder: (context, provider, child) {
//                   if (provider.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (provider.errorMessage.isNotEmpty) {
//                     return Center(
//                         child: Text("Error: ${provider.errorMessage}"));
//                   }
//                   if (provider.students.isEmpty) {
//                     return const Center(child: Text("No students found"));
//                   }

//                   return ListView.builder(
//                     itemCount: provider.students.length,
//                     itemBuilder: (context, index) {
//                       return StudentCard(student: provider.students[index]);
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
>>>>>>> 6bb8d203c3ba40a7d7018df95417f2b1a7632e8f
