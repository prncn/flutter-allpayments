import 'package:allpayments/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleHeader extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color? background;

  const TitleHeader({
    Key? key,
    required this.title,
    required this.icon,
    this.background = Colors.transparent,
  }) : super(key: key);

  @override
  State<TitleHeader> createState() => _TitleHeaderState();
}

class _TitleHeaderState extends State<TitleHeader>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false).drawerIconController =
        AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      foregroundColor: Theme.of(context).colorScheme.onBackground,
      leading: Builder(builder: (context) {
        ScaffoldState? state =
            Provider.of<ThemeProvider>(context, listen: false)
                .scaffoldState
                .currentState;

        return Padding(
          padding: const EdgeInsets.all(14),
          child: GestureDetector(
            onTap: () {
              state?.openDrawer();
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: Provider.of<ThemeProvider>(context, listen: false)
                  .drawerIconController,
            ),
          ),
        );
      }),
      elevation: 0,
      backgroundColor: widget.background,
      title: Row(
        children: [
          Text(
            widget.title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            widget.icon,
            size: 14,
          ),
        ],
      ),
    );
  }
}
