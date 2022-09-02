import 'package:allpayments/provider/route_provider.dart';
import 'package:allpayments/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DevCommentInput extends StatefulWidget {
  const DevCommentInput({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final VoidCallback onSubmit;

  @override
  State<DevCommentInput> createState() => _DevCommentInputState();
}

class _DevCommentInputState extends State<DevCommentInput> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bilal A.',
                style: TextStyle(
                  fontFamily: GoogleFonts.robotoMono().fontFamily,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextButton(
                onPressed: widget.onSubmit,
                child: Text(
                  'cancel',
                  style: TextStyle(
                    fontFamily: GoogleFonts.robotoMono().fontFamily,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.4),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 400,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 5,
                    autofocus: true,
                    controller: controller,
                    style: TextStyle(
                      fontFamily: GoogleFonts.robotoMono().fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 14 / MediaQuery.textScaleFactorOf(context),
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  splashRadius: 18,
                  iconSize: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.4),
                  onPressed: () {
                    final Map<String, dynamic> body = {
                      'creator': 'Bilal A.',
                      'content': controller.text,
                      'date': Timestamp.now(),
                      'screen':
                          Provider.of<RouteProvider>(context, listen: false)
                              .current
                              .name,
                    };

                    writeComment(body);
                    widget.onSubmit();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
