import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/message.dart';
import '../widgets/goup.dart';

class HomeChatScreen extends StatefulWidget {
  const HomeChatScreen({Key? key}) : super(key: key);

  @override
  State<HomeChatScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeChatScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  
  Stream? groups;
  String userName = "";
  String lastMessage = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await DatabaseService()
      .getUserGroups(user!.uid)
      .then((snapshot) {
        setState(() {
          groups = snapshot;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ))
        ],
        title: const Text('Chat',
          style: TextStyle(
            color: Color.fromARGB(255, 67, 67, 67),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 88, 155, 155),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 136, 201, 191),
        elevation: 0,
      ),
      body: groupList(),
    );
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData 
          ? ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GroupComponent(
                groupId: snapshot.data[index]['groupId'],
                userName: snapshot.data[index]['participantName'],
                lastMessage: snapshot.data[index]['lastMessage'],);
            })
          : Container();
        }
    );
  }
}