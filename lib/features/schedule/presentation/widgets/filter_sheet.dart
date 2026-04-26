import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../l10n/app_localizations.dart';
import '../providers/schedule_filter_provider.dart';
import '../../../../l10n/app_localizations.dart';


class ScheduleFilterSheet extends ConsumerStatefulWidget {
  const ScheduleFilterSheet({super.key});

  @override
  ConsumerState<ScheduleFilterSheet> createState() => _ScheduleFilterSheetState();
}

class _ScheduleFilterSheetState extends ConsumerState<ScheduleFilterSheet> {
  late int? _selectedClassId;
  late int? _selectedTeacherId;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(scheduleFiltersProvider);
    _selectedClassId = filters.classId;
    _selectedTeacherId = filters.teacherId;
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(scheduleFilterControllerProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.filterSchedule,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          _buildFilterField(
            label: AppLocalizations.of(context)!.classLabel,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterClassId,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                _selectedClassId = value.isEmpty ? null : int.tryParse(value);
              },
            ),
          ),

          const SizedBox(height: 16),

          _buildFilterField(
            label: AppLocalizations.of(context)!.teacherLabel,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterTeacherId,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                _selectedTeacherId = value.isEmpty ? null : int.tryParse(value);
              },
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedClassId = null;
                      _selectedTeacherId = null;
                    });
                    controller.clearFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(AppLocalizations.of(context)!.clearAll),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateFilter(
                      classId: _selectedClassId,
                      teacherId: _selectedTeacherId,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(AppLocalizations.of(context)!.applyFilters),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFilterField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}