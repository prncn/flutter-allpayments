import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/components/title_header.dart';
import 'package:allpayments/provider/route_provider.dart';
import 'package:allpayments/provider/theme_provider.dart';
import 'package:allpayments/screens/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends Base {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  final Screen name = Screen.home;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: heroImage(),
          ),
          const TitleHeader(
            icon: FeatherIcons.shoppingBag,
            title: 'Welcome',
          ),
          SliverToBoxAdapter(
            child: buildBody(),
          )
        ],
      ),
    );
  }

  Widget heroImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(80)),
      child: Image.asset('images/priya-mistry-supermarket-illustration.jpg'),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good afternoon,\nHatice!',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          const DarkMessageCard(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickNavigationButton(
                label: 'Apps',
                icon: FeatherIcons.box,
                onPress: () {},
              ),
              QuickNavigationButton(
                label: 'QR Codes',
                icon: Icons.qr_code,
                onPress: () {},
              ),
              QuickNavigationButton(
                label: 'Stats',
                icon: FeatherIcons.barChart2,
                onPress: () {},
              ),
              QuickNavigationButton(
                label: 'My Cards',
                icon: Icons.credit_card,
                onPress: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickNavigationButton(
                  label: 'Coupons',
                  icon: Icons.discount_outlined,
                  onPress: () {}),
              QuickNavigationButton(
                label: 'Account',
                icon: FeatherIcons.user,
                onPress: () {},
              ),
              QuickNavigationButton(
                label: 'Lights',
                icon: Icons.tips_and_updates_outlined,
                onPress: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
              QuickNavigationButton(
                label: 'Settings',
                icon: FeatherIcons.settings,
                onPress: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickNavigationButton extends StatelessWidget {
  const QuickNavigationButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              // border: Border.all(),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
        Text(label),
      ],
    );
  }
}

class DarkMessageCard extends StatelessWidget {
  const DarkMessageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: cgiGradientPrimary,
          ),
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: darkSlate,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 18,
                spreadRadius: 6,
                offset: const Offset(6, 10),
              )
            ],
          ),
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Tip of the day'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.tips_and_updates_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Stop spending so much money on candles, please',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
