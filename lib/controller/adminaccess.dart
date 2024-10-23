import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profluenceadmin/nav.dart';

class Adminaccess extends StatefulWidget {
  const Adminaccess({super.key});

  @override
  State<Adminaccess> createState() => _AdminaccessState();
}

class _AdminaccessState extends State<Adminaccess> {
  final TextEditingController _accesscode = TextEditingController();
  String error = "";
  bool loading = false;

  @override
  void dispose() {
    _accesscode.dispose();
    super.dispose();
  }

  Future<void> getAccessCode() async {
    setState(() {
      loading = true;
    });
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc('GQtgEKPgYpePmZqgqhu9NaTF5Nq2')
          .collection('accesscode')
          .get();

      bool isValid = false;

      for (var doc in snapshot.docs) {
        var accessCodeFromFirestore = doc['code'];
        if (_accesscode.text == accessCodeFromFirestore) {
          isValid = true;
          break;
        }
      }

      if (isValid && mounted) {
        // Stop any loading before navigation
        setState(() {
          loading = false;
        });
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SideNavigation()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          error = "No access match, please try again.";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Theres an error Please try again.";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image.png'), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Center(
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: SizedBox(
                width: 300,
                height: 240,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        const Text(
                          'Enter Your Admin Code',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _accesscode,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Enter Access Code',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        loading == false
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1A1F32),
                                ),
                                onPressed: () {
                                  getAccessCode();
                                },
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : const CircularProgressIndicator(),
                        const SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          error,
                          style:
                              const TextStyle(fontSize: 13, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Page')),
      body: const Center(child: Text('You have successfully logged in!')),
    );
  }
}
