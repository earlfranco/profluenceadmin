import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profluenceadmin/dailylogin.dart';
import 'package:profluenceadmin/signuprecords.dart'; // For formatting date

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  List<Map<String, dynamic>> useronline = [];
  Map<String, int> dailyLoginCounts = {};
  bool isLoading = true;
  Map<String, int> monthlySignupCounts = {};
  @override
  void initState() {
    super.initState();
    fetchalluseronline();
    fetchallsignupmonthly();
  }

  Future<void> fetchalluseronline() async {
    try {
      QuerySnapshot userlogindocs =
          await FirebaseFirestore.instance.collection('users').get();

      // Log how many documents are fetched
      debugPrint("Documents fetched: ${userlogindocs.docs.length}");

      // Process the fetched documents and calculate login counts per day
      setState(() {
        useronline = userlogindocs.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        // Log each document for debugging
        for (var record in useronline) {
          debugPrint("Record: $record");
        }

        // Process timesignup to count daily logins
        dailyLoginCounts = _processDailyLoginCounts(useronline);
        isLoading = false; // Data is ready
        debugPrint("Daily Login Counts: $dailyLoginCounts");
      });
    } catch (error) {
      debugPrint("Error fetching online users: $error");
      setState(() {
        isLoading = false; // Set to false even if there's an error
      });
    }
  }

  Future<void> fetchallsignupmonthly() async {
    try {
      QuerySnapshot userlogindocs =
          await FirebaseFirestore.instance.collection('users').get();

      debugPrint("Documents fetched: ${userlogindocs.docs.length}");
      setState(() {
        useronline = userlogindocs.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        for (var record in useronline) {
          debugPrint("Record: $record");
        }
        monthlySignupCounts = _processMonthlySignupCounts(useronline);
        isLoading = false;
        debugPrint("Monthly Signup Counts: $monthlySignupCounts");
      });
    } catch (error) {
      debugPrint("Error fetching user signups: $error");
      setState(() {
        isLoading = false; // Set to false even if there's an error
      });
    }
  }

  Map<String, int> _processMonthlySignupCounts(
      List<Map<String, dynamic>> userRecords) {
    Map<String, int> monthlySignups = {};

    for (var record in userRecords) {
      if (record['timesignup'] != null) {
        try {
          Timestamp timestamp = record['timesignup'];
          DateTime date = timestamp.toDate();
          String month = DateFormat('MMM').format(date);

          debugPrint("Processed month: $month from timestamp: $timestamp");

          if (monthlySignups.containsKey(month)) {
            monthlySignups[month] = monthlySignups[month]! + 1;
          } else {
            monthlySignups[month] = 1;
          }
        } catch (e) {
          debugPrint("Error processing record: $record");
        }
      } else {
        debugPrint("timesignup field is null in record: $record");
      }
    }

    return monthlySignups;
  }

  Map<String, int> _processDailyLoginCounts(
      List<Map<String, dynamic>> userRecords) {
    Map<String, int> dailyLogins = {};

    for (var record in userRecords) {
      if (record['timesignup'] != null) {
        try {
          Timestamp timestamp = record['timesignup'];
          DateTime date = timestamp.toDate();
          String day =
              DateFormat('EEE').format(date); // Format as 'Mon', 'Tue', etc.

          debugPrint("Processed day: $day from timestamp: $timestamp");

          if (dailyLogins.containsKey(day)) {
            dailyLogins[day] = dailyLogins[day]! + 1;
          } else {
            dailyLogins[day] = 1;
          }
        } catch (e) {
          debugPrint("Error processing record: $record");
        }
      } else {
        debugPrint("timesignup field is null in record: $record");
      }
    }

    return dailyLogins;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (dailyLoginCounts.isEmpty)
            const Center(
              child: Text("No login data available"),
            )
          else
            Row(
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: const Color(0xff1A1F32),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              "Monthly Signup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SignupRecords(
                              monthlySignupCounts: monthlySignupCounts),
                        ],
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff1A1F32),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                "Daily Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DialyLogin(dailyLoginCounts: dailyLoginCounts),
                          ],
                        ))),
              ],
            ),
        ],
      ),
    );
  }
}
