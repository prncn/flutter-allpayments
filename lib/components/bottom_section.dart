import 'package:flutter/material.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    Key? key,
    required this.icon,
    required this.title,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Column child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50)),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          child,
        ],
      ),
    );
  }
}
