import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_sos_app/utils/colors.dart';

class StudentFormWidget extends StatefulWidget {
  const StudentFormWidget({super.key});

  @override
  State<StudentFormWidget> createState() => _StudentFormWidgetState();
}

class _StudentFormWidgetState extends State<StudentFormWidget> {
  TextEditingController matricNoTextController = TextEditingController();
  TextEditingController langTextController =
      TextEditingController(text: "English");
  final _formKey = GlobalKey<FormState>();

  List languages = [
    {"id": 1, "name": "English"},
    {"id": 2, "name": "Yoruba"},
    {"id": 3, "name": "Igbo"},
    {"id": 4, "name": "Hausa"},
  ];
  @override
  Widget build(BuildContext context) {
    const minHeight = 640;
    final screenHieght = MediaQuery.of(context).size.height;
    final kSize = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return ListView(
      children: [
        Text(
          "Welcome,",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: const Color(0xFF191D3E),
              ),
        ),
        Text(
          "Enter your Username, Matric number and the language of your choice to continue.",
          style: theme.bodyMedium?.copyWith(color: const Color(0xFF191D3E)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Matric Number",
                  style: theme.bodyLarge?.copyWith(
                      color: const Color(0xFF191D3E),
                      fontWeight: FontWeight.w600),
                ),
                buildTextMatricNumber(screenHieght, minHeight, theme),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Username",
                  style: theme.bodyLarge?.copyWith(
                      color: const Color(0xFF191D3E),
                      fontWeight: FontWeight.w600),
                ),
                buildTextUsername(screenHieght, minHeight, theme),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Language",
                  style: theme.bodyLarge?.copyWith(
                      color: const Color(0xFF191D3E),
                      fontWeight: FontWeight.w600),
                ),
                buildLanguageInput(screenHieght, minHeight, theme),
                const SizedBox(
                  height: 20,
                ),
                _buildButtonOnSubmit(
                    kSize, context, "Continue", screenHieght, minHeight,
                    () async {
                  Navigator.pushNamed(context, '/tab-screen');
                })
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildTextUsername(double screenHeight, int minHeight, theme) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Username is Required";
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              matricNoTextController.text = value!;
            });
          },
          controller: matricNoTextController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: primaryColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: primaryColor)),
            filled: true,
            fillColor: fadedGrayColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ),
          style: theme.bodyMedium?.copyWith(
            color: const Color(0xFF191D3E),
          )),
    );
  }

  Widget buildTextMatricNumber(double screenHeight, int minHeight, theme) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Matric Number is Required";
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              matricNoTextController.text = value!;
            });
          },
          controller: matricNoTextController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: primaryColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: primaryColor)),
            filled: true,
            fillColor: fadedGrayColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ),
          style: theme.bodyMedium?.copyWith(
            color: const Color(0xFF191D3E),
          )),
    );
  }

  Widget buildLanguageInput(double screenHeight, int minHeight, theme) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: TextFormField(
          onTap: () {
            _showLanguageBottomSheet(context, theme);
          },
          controller: langTextController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.arrow_drop_down),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: primaryColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: primaryColor)),
            filled: true,
            fillColor: fadedGrayColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          ),
          style: theme.bodyMedium?.copyWith(
            color: const Color(0xFF191D3E),
          )),
    );
  }

  void _showLanguageBottomSheet(BuildContext context, theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Select Languages',
                style: GoogleFonts.openSans(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
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
                          langTextController.text = languages[index]['name'];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonOnSubmit(Size kSize, BuildContext context,
      String buttonText, double screenHeight, int minHeight, Function func) {
    return SizedBox(
      height: 55,
      width: kSize.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            minimumSize: kSize,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onPressed: func as void Function()?,
        child: Text(buttonText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenHeight > minHeight ? 15 : 14)),
      ),
    );
  }
}
