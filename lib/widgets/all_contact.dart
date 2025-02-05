import 'package:flutter/material.dart';

class AllContactWidget extends StatelessWidget {
  const AllContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        "Contact Lists",
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: const Color(0xFF191D3E),
            ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 10,
      ),
      Expanded(
        child: ListView.builder(
          itemCount: 3,
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
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                title: Text(
                  "Racheal Adeyemi",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF191D3E),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "+2349076252618",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      onPressed: () {},
                      color: Colors.blue),
                  const SizedBox(width: 20),
                  FadedEditButton(
                      text: 'Remove',
                      icon: Icons.delete_outline_outlined,
                      onPressed: () {},
                      color: Colors.red)
                ],
              )
                  ],
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("New", style:Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.teal,
                        fontStyle: FontStyle.italic,),
                )),
                // trailing: Text(
                //   "21st Jan, 2025",
                //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                //         color: const Color(0xFF191D3E),
                //         fontStyle: FontStyle.italic,
                      // ),
                // ),
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
