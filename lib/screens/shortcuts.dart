import 'package:allpayments/assets/constants.dart';
import 'package:allpayments/components/bottom_section.dart';
import 'package:allpayments/env.dart';
import 'package:allpayments/models/market_model.dart';
import 'package:allpayments/screens/base.dart';
import 'package:allpayments/services/maps_gl.dart';
import 'package:allpayments/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

class ShortcutsScreen extends StatefulWidget {
  const ShortcutsScreen({Key? key}) : super(key: key);

  @override
  State<ShortcutsScreen> createState() => _ShortcutsScreenState();
}

class _ShortcutsScreenState extends State<ShortcutsScreen> {
  Color ambient = pennyMarket.color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
            // color: backgroundColor,
            // gradient: LinearGradient(
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   stops: const [0.8, 1],
            //   colors: [backgroundColor, lighten(ambient, 0.4)],
            // ),
            ),
        child: CustomScrollView(
          slivers: [
            const TitleHeader(
              icon: FeatherIcons.box,
              title: 'Shortcuts',
            ),
            SliverToBoxAdapter(
              child: buildBody(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        heroCardRow(),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: double.infinity,
          height: 500,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BottomSection(
                icon: Icons.storefront_outlined,
                title: 'Shops near you',
                child: Column(
                  children: [
                    shopsNearTile(),
                    shopsNearTile(),
                  ],
                ),
              ),
              Positioned(
                top: 250,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(20)),
                  child: Container(
                      width: 500,
                      height: 500,
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0, 0.2],
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Builder(builder: (context) {
                        latlong.LatLng? center =
                            latlong.LatLng(50.137329, 8.506595);
                        return FlutterMap(
                          options: MapOptions(
                            center: center,
                            zoom: 15,
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                                  'https://api.mapbox.com/styles/v1/prncn/cl6kk3d0d002r14mrm85zkbsr/tiles/256/{z}/{x}/{y}@2x?access_token={access_token}',
                              additionalOptions: {'access_token': mapBoxToken},
                            ),
                            MarkerLayerOptions(markers: [
                              Marker(
                                  width: 45,
                                  height: 45,
                                  point: center,
                                  builder: (context) {
                                    return Icon(
                                      Icons.location_on_sharp,
                                      color: lighten(cgiPurpleSat),
                                      size: 45,
                                    );
                                  }),
                            ])
                          ],
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shopsNearTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Friesen - Wolff',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '6488 Greenfelder Islands, MS, KN',
                style: TextStyle(
                  height: 1.8,
                  fontSize: 12,
                  color: darkGray.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Text(
            '~100m',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: darkGray.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView heroCardRow() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          marketAppIcon(pennyMarket),
          marketAppIcon(reweMarket),
          marketAppIcon(nettoMarket),
          marketAppIcon(edekaMarket),
          marketAppIcon(dmMarket),
        ],
      ),
    );
  }

  Widget marketAppIcon(MarketData market) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ambient = market.color;
        });
      },
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: market.color.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 12,
          ),
        ]),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(6),
        child: market.logo,
      ),
    );
  }
}

class MarketCard extends StatefulWidget {
  const MarketCard({
    Key? key,
    required this.market,
  }) : super(key: key);

  final MarketData market;

  @override
  State<MarketCard> createState() => _MarketCardState();
}

class _MarketCardState extends State<MarketCard> {
  Color textColor = Colors.black;
  double shadowOpacity = 0.4;
  Color color = Colors.white;

  @override
  void initState() {
    super.initState();
    color = darken(desaturate(widget.market.color, 0.4));
    if (color.computeLuminance() > 0.5) {
      textColor = Colors.black;
    }
    shadowOpacity = (1 - color.computeLuminance()) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkGray.withOpacity(0.05),
            blurRadius: 30,
            spreadRadius: 3,
            offset: const Offset(10, 15),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.market.name,
            style: TextStyle(
              color: textColor,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '**** 8137',
            softWrap: true,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          const Text(
            'USD',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '29,300.00',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
