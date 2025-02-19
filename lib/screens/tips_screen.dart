import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:personal_sos_app/services/model/tips_model.dart';
import 'package:personal_sos_app/utils/colors.dart';
class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  EmergencyModel? emergencyData;

  @override
  void initState() {
    super.initState();
    loadEmergencyData();
  }

  Future<void> loadEmergencyData() async {
    final String jsonString =
        await rootBundle.loadString('assets/lang/tips.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    setState(() {
      emergencyData = EmergencyModel.fromJson(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.transparent,
     appBar: AppBar(
        title:const Text("Emergency SOS Tips"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: emergencyData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
              
                const SizedBox(height: 10),
                ...emergencyData!.emergencySosTips.map((tip) => Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ExpansionTile(
                        title: Text(
                          tip.title,
                          style:  TextStyle(
                              fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        children: tip.tips!.map((t) => ListTile(
                                  title: Text(t),
                                  leading:  Icon(Icons.info, color: primaryColor),
                                ))
                            .toList(),
                      ),
                    )),
             
              ],
            ),
    );
  }
}
