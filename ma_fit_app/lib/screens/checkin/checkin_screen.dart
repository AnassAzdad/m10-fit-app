import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../models/checkin.dart';
import '../../core/checkin_service.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  int selectedMood = 3;
  final controller = TextEditingController();

  bool loadingStatus = true;
  bool checkedToday = false;

  bool loadingHistory = true;
  List<CheckIn> history = [];

  bool submitting = false;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _loadAll() async {
    await Future.wait([
      _loadStatus(),
      _loadHistory(),
    ]);
  }

  Future<void> _loadStatus() async {
    setState(() => loadingStatus = true);
    try {
      final ok = await CheckInService.hasCheckedInToday();
      if (!mounted) return;
      setState(() {
        checkedToday = ok;
        loadingStatus = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => loadingStatus = false);
    }
  }

  Future<void> _loadHistory() async {
    setState(() => loadingHistory = true);
    try {
      final rows = await CheckInService.getMyCheckIns();
      if (!mounted) return;
      setState(() {
        history = rows.reversed.toList();
        loadingHistory = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => loadingHistory = false);
    }
  }

  Future<void> _submit() async {
    if (submitting) return;

    setState(() => submitting = true);

    try {
      await CheckInService.addCheckIn(
        mood: selectedMood,
        note: controller.text.trim(),
        opleiding: AppState.currentUser?.opleiding ?? '',
        klas: AppState.currentUser?.klas ?? '',
      );

      controller.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check-in opgeslagen ✅')),
      );

      await _loadAll();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kon niet opslaan: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() => submitting = false);
    }
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}-'
        '${d.month.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:'
        '${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadAll,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          /// STATUS
          _StatusCard(
            loading: loadingStatus,
            checkedToday: checkedToday,
          ),
          const SizedBox(height: 12),

          /// CHECK-IN KAART
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [Color(0xFF0F1535), Color(0xFF080A1A)],
              ),
              border: Border.all(
                color: const Color(0xFFFF4B91).withOpacity(0.5),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF4B91).withOpacity(0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dagelijkse check-in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Hoe voel je je vandaag?',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 18),

                /// MOOD SELECTIE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (i) {
                    final mood = i + 1;
                    final active = mood == selectedMood;

                    return GestureDetector(
                      onTap: () => setState(() => selectedMood = mood),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active
                              ? const Color(0xFFFF4B91)
                              : const Color(0xFF141A2E),
                          boxShadow: active
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFFFF4B91)
                                        .withOpacity(0.6),
                                    blurRadius: 16,
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                         child: Text(
  const ['😞', '😕', '😐', '🙂', '😄'][mood - 1],
  style: const TextStyle(
    fontSize: 22,
    color: Colors.white,
    fontWeight: FontWeight.w800,
  ),
),

                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 18),

                /// NOTITIE
                TextField(
                  controller: controller,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Wil je iets kwijt?',
                    hintStyle:
                        TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: const Color(0xFF141A2E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4B91),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: submitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Opslaan',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          /// RECENTE CHECK-INS
          const Text(
            'Recente check-ins',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),

          if (loadingHistory)
            const Center(child: CircularProgressIndicator())
          else if (history.isEmpty)
            Text(
              'Nog geen check-ins.',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            )
          else
            ...history.take(5).map(
                  (c) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xFF141A2E),
                    ),
                    child: Text(
                      'Mood ${c.mood} • ${_formatDate(c.date)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final bool loading;
  final bool checkedToday;

  const _StatusCard({
    required this.loading,
    required this.checkedToday,
  });

  @override
  Widget build(BuildContext context) {
    final Color color =
        checkedToday ? const Color(0xFF6EEB83) : const Color(0xFFFFD166);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF141A2E),
        border: Border.all(color: color.withOpacity(0.8)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            checkedToday ? Icons.check_circle : Icons.info,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              loading
                  ? 'Status laden…'
                  : checkedToday
                      ? 'Vandaag al ingecheckt'
                      : 'Nog niet ingecheckt',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
