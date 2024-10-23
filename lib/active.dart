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
          DateTime(currentDate.year, currentDate.month - 1, currentDate.day);

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('timesignup', isGreaterThanOrEqualTo: oneMonthAgo)
          .limit(10)
          .get();

      List<Map<String, dynamic>> users = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      setState(() {
        userData = users;
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
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                const Center(
                    child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'MONTHLY ACTIVE USER ',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                )),
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: userData!.length,
                    itemBuilder: (context, index) {
                      final currentdata = userData![index];
                      if (currentdata['isonline'] != 0) {
                        activenumber = currentdata.length;
                        return ListTile(
                          leading: CircleAvatar(
                            foregroundImage:
                                NetworkImage(currentdata['profileImage']),
                          ),
                          title: Text(
                            currentdata['name'] ?? 'No Name',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Text(currentdata['email'] ?? 'No Email'),
                          trailing: const Icon(
                            Icons.circle_outlined,
                            color: Colors.lightGreenAccent,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
