import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:personal_sos_app/services/model/contact_model.dart';
import 'package:personal_sos_app/services/providers/contact_provider.dart';
import 'package:personal_sos_app/utils/colors.dart';
import 'package:provider/provider.dart';

class UpdateContactWidget extends StatefulWidget {
  final ContactModel contact;
  const UpdateContactWidget({super.key, required this.contact});

  @override
  State<UpdateContactWidget> createState() => _UpdateContactWidgetState();
}

class _UpdateContactWidgetState extends State<UpdateContactWidget> {
  late TextEditingController firstNameTextController;
  late TextEditingController lastNameTextController;
  late TextEditingController phoneTextController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameTextController =
        TextEditingController(text: widget.contact.firstName);
    lastNameTextController =
        TextEditingController(text: widget.contact.lastName);
    phoneTextController =
        TextEditingController(text: widget.contact.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    const minHeight = 640;
    final screenHieght = MediaQuery.of(context).size.height;
    final kSize = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    final contactProvider = Provider.of<ContactProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Edit Contact",
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: const Color(0xFF191D3E),
            ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                  buildTextFirstname(
                      screenHieght, minHeight, theme, contactProvider.isSaving),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Last Name",
                    style: theme.bodyLarge?.copyWith(
                        color: const Color(0xFF191D3E),
                        fontWeight: FontWeight.w600),
                  ),
                  buildTextLastname(
                      screenHieght, minHeight, theme, contactProvider.isSaving),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Phone Number",
                    style: theme.bodyLarge?.copyWith(
                        color: const Color(0xFF191D3E),
                        fontWeight: FontWeight.w600),
                  ),
                  buildTextPhone(
                      screenHieght, minHeight, theme, contactProvider.isSaving),
                  const SizedBox(
                    height: 20,
                  ),
                  contactProvider.isSaving
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : _buildButtonOnSubmit(
                          kSize,
                          context,
                          "save".tr(),
                          screenHieght,
                          minHeight,
                          () async {
                            // Save the contact
                            await contactProvider.updateContact(
                              widget.contact.id,
                              firstNameTextController.text.trim(),
                              lastNameTextController.text.trim(),
                              phoneTextController.text.trim(),
                            );

                            if (contactProvider.successMessage.isNotEmpty) {
                              showSuccessDialog(contactProvider.successMessage);
                            } else if (contactProvider
                                .failedMessage.isNotEmpty) {
                              showFailedDialog(contactProvider.failedMessage);
                            }
                          },
                          contactProvider.isSaving,
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showSuccessDialog(successMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Load and display the success GIF
              Image.asset(
                'assets/gifs/success.gif',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Success!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                successMessage,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.popAndPushNamed(context, '/tab-screen');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showFailedDialog(failedMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Load and display the success GIF
              Image.asset(
                'assets/gifs/failed.gif',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Failed!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                failedMessage,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Load and display the success GIF
              Image.asset(
                'assets/gifs/loading.gif',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Saving...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextFirstname(
      double screenHeight, int minHeight, theme, loading) {
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
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            enabled: !loading,
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

  Widget buildTextLastname(double screenHeight, int minHeight, theme, loading) {
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
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            enabled: !loading,
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

  Widget buildTextPhone(double screenHeight, int minHeight, theme, loading) {
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
          enabled: !loading,
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
              prefix: Text("+234",
                  style: theme.bodyMedium?.copyWith(
                    color: const Color(0xFF191D3E),
                  )),
              prefixStyle: theme.bodyMedium?.copyWith(
                color: const Color(0xFF191D3E),
              )),
          style: theme.bodyMedium?.copyWith(
            color: const Color(0xFF191D3E),
          )),
    );
  }

  Widget _buildButtonOnSubmit(
      Size kSize,
      BuildContext context,
      String buttonText,
      double screenHeight,
      int minHeight,
      Function func,
      loading) {
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
        child: loading
            ? const CircularProgressIndicator()
            : Text(buttonText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: screenHeight > minHeight ? 15 : 14)),
      ),
    );
  }
}
