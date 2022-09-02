import 'package:allpayments/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart';

class DevComment extends StatefulWidget {
  const DevComment({
    Key? key,
    required this.content,
    required this.creator,
    required this.date,
    required this.id,
  }) : super(key: key);

  final String creator;
  final String content;
  final Timestamp date;
  final String id;

  @override
  State<DevComment> createState() => _DevCommentState();
}

class _DevCommentState extends State<DevComment> {
  bool _isHovered = false;
  bool _editMode = false;
  String newContent = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (isHover) {
        setState(() {
          _isHovered = isHover;
        });
      },
      focusColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.01),
      hoverColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.01),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.creator,
                    style: TextStyle(
                      fontFamily: GoogleFonts.robotoMono().fontFamily,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  _editMode
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              _editMode = false;
                            });
                          },
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
                      : Text(
                          format((widget.date).toDate()),
                          style: TextStyle(
                            fontFamily: GoogleFonts.robotoMono().fontFamily,
                          ),
                        )
                ],
              ),
            ),
            const SizedBox(height: 4),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  !_editMode
                      ? Expanded(
                          child: Text(
                            widget.content,
                            softWrap: true,
                            style: TextStyle(
                              fontFamily: GoogleFonts.robotoMono().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      : SizedBox(
                          child: TextFormField(
                            maxLines: 5,
                            initialValue: widget.content,
                            onChanged: (text) => setState(() {
                              newContent = text;
                            }),
                            scrollPadding: EdgeInsets.zero,
                            autofocus: true,
                            style: TextStyle(
                              fontFamily: GoogleFonts.robotoMono().fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  14 / MediaQuery.textScaleFactorOf(context),
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 40,
                    child: _isHovered
                        ? _editMode
                            ? IconButton(
                                splashRadius: 18,
                                iconSize: 16,
                                onPressed: () async {
                                  await updateComment(newContent, widget.id);
                                  setState(() {
                                    _editMode = false;
                                  });
                                },
                                icon: const Icon(Icons.send),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.4),
                              )
                            : Row(
                                children: [
                                  IconButton(
                                    splashRadius: 18,
                                    iconSize: 16,
                                    onPressed: () {
                                      _editMode = true;
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.4),
                                  ),
                                  IconButton(
                                    splashRadius: 18,
                                    iconSize: 16,
                                    onPressed: () {
                                      deleteComment(widget.id);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.4),
                                  ),
                                ],
                              )
                        : null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
