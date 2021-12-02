import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rapid_reps/models/export.dart';

class TestList extends StatefulWidget {
  final CDOModel currentUser;
  const TestList({Key? key, required this.currentUser}) : super(key: key);

  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("jobs"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection('jobs')
              .where('uidCDO', isEqualTo: widget.currentUser.uid)
              .orderBy('dateCreated', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final jobs = snapshot.data!.docs;
              jobs.sort((a, b) {
                return a['jobCompleted']
                    .toString()
                    .compareTo(b['jobCompleted'].toString());
              });
              return ListView(
                children: jobs.map((doc) {
                  return Card(
                    child: ListTile(
                      title: Text(doc.id),
                      tileColor:
                          doc['jobCompleted'] ? Colors.green : Colors.red,
                      subtitle: Text(doc['jobType']),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
