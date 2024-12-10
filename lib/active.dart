import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActiveUsers extends StatefulWidget {
  const ActiveUsers({super.key});

  @override
  State<ActiveUsers> createState() => _ActiveUsersState();
}

class _ActiveUsersState extends State<ActiveUsers> {
  List<Map<String, dynamic>>? userData;
  int activenumber = 0;

  Future<void> fetchUserData() async {
    try {
      DateTime currentDate = DateTime.now();
      DateTime oneMonthAgo =
          DateTime(currentDate.year, currentDate.month - 2, currentDate.day);

      Timestamp oneMonthAgoTimestamp = Timestamp.fromDate(oneMonthAgo);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('timesignup', isGreaterThanOrEqualTo: oneMonthAgoTimestamp)
          .get();

      List<Map<String, dynamic>> users = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Update the state with fetched data
      setState(() {
        userData = users;
        activenumber = users.length; // Count active users
      });
    } catch (e) {
      debugPrint('Error fetching users: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return userData != null
        ? Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xff1A1F32),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'MONTHLY ACTIVE USERS: $activenumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: userData!.length,
                  itemBuilder: (context, index) {
                    final currentdata = userData![index];
                    return Card(
                      color: const Color(0xff2A2F4F),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          foregroundImage: currentdata['profileImage'] != null
                              ? NetworkImage(currentdata['profileImage'])
                              : null,
                          backgroundColor: Colors.grey,
                          child: currentdata['profileImage'] == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                        title: Text(
                          currentdata['name'] ?? 'No Name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          currentdata['email'] ?? 'No Email',
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.circle_outlined,
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
  }
}
