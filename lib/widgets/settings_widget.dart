import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    List languages = [
      {"id": 1, "name": "English"},
      {"id": 2, "name": "Yoruba"},
      {"id": 3, "name": "Igbo"},
      {"id": 4, "name": "Hausa"},
    ];

    final theme = Theme.of(context).textTheme;
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        "Languages",
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: const Color(0xFF191D3E),
            ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 60,
      ),
      Text(
        'Select Languages',
        style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: languages.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5)),
                  child: Text("${languages[index]['name'][0]}L",
                      style: theme.bodyLarge?.copyWith(
                          color: const Color(0xFF191D3E),
                          fontWeight: FontWeight.bold)),
                ),
                title: Text(
                  "${languages[index]['name']}",
                  style: theme.bodyLarge?.copyWith(
                      color: const Color(0xFF191D3E),
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  setState(() {
                    // langTextController.text = languages[index]['name'];
                  });
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
    ]);
  }
}
