import 'package:flutter/material.dart';
import '../pages/chat.dart';


class GroupComponent extends StatefulWidget {
  const GroupComponent({Key? key, required this.groupId, required this.userName, required this.lastMessage}): super(key: key);
      
  final String userName;
  final String groupId;
  final String lastMessage;

  @override
  State<GroupComponent> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(idGroup: widget.groupId, userName: widget.userName,),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromARGB(255, 88, 155, 155),
            child: Text(
              widget.userName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.userName,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 88, 155, 155)),
          ),
          subtitle: Text(
            widget.lastMessage,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}