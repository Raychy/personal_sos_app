import 'package:flutter/material.dart';
import 'package:personal_sos_app/utils/colors.dart';

class NewContactWidget extends StatefulWidget {
  const NewContactWidget({super.key});

  @override
  State<NewContactWidget> createState() => _NewContactWidgetState();
}

class _NewContactWidgetState extends State<NewContactWidget> {
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const minHeight = 640;
    final screenHieght = MediaQuery.of(context).size.height;
    final kSize = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "New Contact",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: const Color(0xFF191D3E),
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
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
                  "First Name",
                  style: theme.bodyLarge?.copyWith(
                      color: const Color(0xFF191D3E),
                      fontWeight: FontWeight.w600),
                ),
                buildTextFirstname(screenHieght, minHeight, theme),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Last Name",
                  style: theme.bodyLarge?.copyWith(
                      color: const Color(0xFF191D3E),
                      fontWeight: FontWeight.w600),
                ),
                buildTextLastname(screenHieght, minHeight, theme),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone Number",
                  style: theme.bodyLarge?.copyWith(
                      color: const Color(0xFF191D3E),
                      fontWeight: FontWeight.w600),
                ),
                buildTextPhone(screenHieght, minHeight, theme),
                const SizedBox(
                  height: 20,
                ),
                _buildButtonOnSubmit(
                    kSize, context, "Save", screenHieght, minHeight,
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

  Widget buildTextFirstname(double screenHeight, int minHeight, theme) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Firstname is required";
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              firstNameTextController.text = value!;
            });
          },
          controller: firstNameTextController,
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

  Widget buildTextLastname(double screenHeight, int minHeight, theme) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Matric Number is required";
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              lastNameTextController.text = value!;
            });
          },
          controller: lastNameTextController,
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

  Widget buildTextPhone(double screenHeight, int minHeight, theme) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Phone number is required";
            }
            return null;
          },
          onSaved: (value) {
            setState(() {
              phoneTextController.text = value!;
            });
          },
          controller: phoneTextController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
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
