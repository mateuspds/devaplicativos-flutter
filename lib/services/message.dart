import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference groupCollection =
    FirebaseFirestore.instance.collection("groups");

  Future createGroup(String admin, String participant,  String participantName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "admin": admin,
      "participant": participant,
      "lastMessage": "",
      "time": "",
      "participantName": participantName,
    });

    await groupDocumentReference.update({
      "groupId": groupDocumentReference.id,
    });

    return groupDocumentReference.id;
  }

  getChats(String groupId) async {
    return groupCollection
      .doc(groupId)
      .collection("messages")
      .orderBy("time")
      .snapshots();
  }

  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    
    groupCollection.doc(groupId).update({
      "lastMessage": chatMessageData['message'],
      "time": chatMessageData['time'].toString(),
    });
  }

  Future getGroupUsers(String admin, String participant) async {
    final groupDocumentReference = await groupCollection
      .where("admin", isEqualTo: admin)
      .where("participant", isEqualTo: participant)
      .get();

     if (groupDocumentReference.docs.isNotEmpty) {
      return groupDocumentReference.docs[0].id;
    } else {
      return null;
    }
  }

  getUserGroups(String user) async {
    final adminQuery = groupCollection
      .where("admin", isEqualTo: user)
      .snapshots();

    final participantQuery = groupCollection
      .where("participant", isEqualTo: user)
      .snapshots();

    final combinedStream = Rx.combineLatest2(adminQuery, participantQuery, (adminSnapshot, participantSnapshot) => [
      ...adminSnapshot.docs,
      ...participantSnapshot.docs
    ]);

    return combinedStream;
  }
}