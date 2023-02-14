import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  final String message;
  final bool sentByMe;

  const Message(
      {Key? key,
      required this.message,
      required this.sentByMe})
      : super(key: key);

  @override
  State<Message> createState() => _MessageTileState();
}

class _MessageTileState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: widget.sentByMe ? 0 : 16,
        right: widget.sentByMe ? 16 : 0),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe
          ? const EdgeInsets.only(left: 30)
          : const EdgeInsets.only(right: 30),
        padding:
          const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        decoration: BoxDecoration(
            borderRadius: widget.sentByMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
            color: widget.sentByMe
              ? const Color.fromARGB(255, 209, 231, 228)
              : Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 16, 
                color: Color.fromARGB(255, 67, 67, 67),
              ),
            ),
          ],
        ),
      ),
    );
  }
}