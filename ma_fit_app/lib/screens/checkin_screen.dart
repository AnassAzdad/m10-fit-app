import 'package:flutter/material.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  double _moodValue = 5; // 1–10
  bool _sleptWell = false;
  bool _movedToday = false;
  bool _talkedToSomeone = false;

  void _saveCheckin() {
    // Voor nu alleen een SnackBar laten zien
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Je check-in is opgeslagen 💜'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-in'),
        centerTitle: true,
      ),
      body: Container(
        // Zelfde zachte achtergrond als de andere schermen
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5E8FF),
              Color(0xFFF7F8FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          // Mobile-first: scroll + max breedte
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoe gaat het met je vandaag?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Vul kort in hoe je je voelt en vink aan wat voor jou klopt.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // BOX 1: Mood slider
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 16,
                          spreadRadius: 1,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '1. Hoe voel je je (1–10)?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text('Slecht'),
                            Expanded(
                              child: Slider(
                                value: _moodValue,
                                min: 1,
                                max: 10,
                                divisions: 9,
                                label: _moodValue.round().toString(),
                                activeColor: const Color(0xFF4F46E5),
                                onChanged: (value) {
                                  setState(() {
                                    _moodValue = value;
                                  });
                                },
                              ),
                            ),
                            const Text('Top'),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Huidige score: ${_moodValue.round()} / 10',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

               
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 16,
                          spreadRadius: 1,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '2. Vandaag...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _CheckItem(
                          label: 'Ik heb goed geslapen',
                          value: _sleptWell,
                          onChanged: (v) {
                            setState(() => _sleptWell = v);
                          },
                        ),
                        _CheckItem(
                          label: 'Ik heb bewogen / gesport',
                          value: _movedToday,
                          onChanged: (v) {
                            setState(() => _movedToday = v);
                          },
                        ),
                        _CheckItem(
                          label: 'Ik heb met iemand gepraat over hoe ik me voel',
                          value: _talkedToSomeone,
                          onChanged: (v) {
                            setState(() => _talkedToSomeone = v);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

               
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveCheckin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F46E5),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Opslaan',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _CheckItem extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CheckItem({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: (v) => onChanged(v ?? false),
      activeColor: const Color(0xFF4F46E5),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
