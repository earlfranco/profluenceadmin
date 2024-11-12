import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GenerateAccessCode extends StatefulWidget {
  const GenerateAccessCode({super.key});

  @override
  State<GenerateAccessCode> createState() => _GenerateAccessCodeState();
}

class _GenerateAccessCodeState extends State<GenerateAccessCode> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.40,
            height: 430,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff1A1F32),
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('admin')
                    .doc('GQtgEKPgYpePmZqgqhu9NaTF5Nq2')
                    .collection('accesscode')
                    .snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshots.hasData ||
                      snapshots.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No Access Code available"),
                    );
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 0.02,
                          mainAxisSpacing: 0.23,
                        ),
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var doc = snapshots.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: Text(
                                doc['code'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          isloading == false
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent),
                  onPressed: () {
                    String generatedCode = generateRandomCode(8);
                    uploadCodeToFirestore(generatedCode);
                  },
                  child: const Text(
                    "Generate Code",
                    style: TextStyle(color: Colors.white),
                  ))
              : const CircularProgressIndicator()
        ],
      ),
    );
  }

  String generateRandomCode(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  Future<void> uploadCodeToFirestore(String code) async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc('GQtgEKPgYpePmZqgqhu9NaTF5Nq2')
          .collection('accesscode')
          .add({'code': code, 'timestamp': FieldValue.serverTimestamp()});
      setState(() {
        isloading = false;
      });
    } catch (e) {
      debugPrint("error $e");
    }
  }
}
