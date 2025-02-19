// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:personal_sos_app/services/providers/contact_provider.dart';
import 'package:personal_sos_app/widgets/update_contact.dart';
import 'package:provider/provider.dart';

class AllContactWidget extends StatelessWidget {
  const AllContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    void showDeleteConfirmationDialog(BuildContext context, dynamic contact) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Confirm Deletion'),
            content:
                Text('Are you sure you want to delete ${contact.firstName}?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext)
                      .pop(); // Close dialog without action
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await contactProvider.deleteContact(contact.id);
                  Navigator.of(dialogContext).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('${contact.firstName} deleted successfully'),
                    ),
                  );
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    }

    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        "contact_list".tr(),
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: const Color(0xFF191D3E),
            ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 10,
      ),
      contactProvider.isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : contactProvider.sosContacts.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 58.0),
                    child: Text(
                      "No contacts added yet!",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF191D3E),
                            fontWeight: FontWeight.normal,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    itemCount: contactProvider.sosContacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final reversedIndex = contactProvider.sosContacts.length - 1 - index;
                      final contact = contactProvider.sosContacts[reversedIndex];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
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
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                          title: Text(
                            "${contact.firstName} ${contact.lastName}",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xFF191D3E),
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "+234${contact.phoneNumber}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: const Color(0xFF191D3E),
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadedEditButton(
                                      text: 'Edit',
                                      icon: Icons.edit,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                UpdateContactWidget(
                                                    contact: contact));
                                      },
                                      color: Colors.blue),
                                  const SizedBox(width: 20),
                                  FadedEditButton(
                                      text: 'Remove',
                                      icon: Icons.delete_outline_outlined,
                                      onPressed: () {
                                        showDeleteConfirmationDialog(
                                            context, contact);
                                      },
                                      color: Colors.red)
                                ],
                              )
                            ],
                          ),
                          trailing: DateTime.now()
                                        .difference(contact.dateTime)
                                      .inDays ==
                                  0
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "New",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.teal,
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ))
                              : Text(
                                  DateFormat('dd MMM, yyyy')
                                      .format(contact.dateTime),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: const Color(0xFF191D3E),
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
    ]);
  }
}

class FadedEditButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const FadedEditButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color,
        size: 20,
      ),
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: color.withOpacity(0.2)),
    );
  }
}
