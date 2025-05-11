import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/firebase_options.dart';
import 'package:tailor_app/provider/family/family_create_provide.dart';
import 'package:tailor_app/provider/family/family_member_dialog_provider.dart';
import 'package:tailor_app/provider/family/family_member_provider.dart';
import 'package:tailor_app/provider/family/family_record_provider.dart';
import 'package:tailor_app/provider/individual/individual_dialog_provider.dart';
import 'package:tailor_app/provider/individual/individual_screen_provider.dart';
import 'package:tailor_app/provider/individual/individual_update_provider.dart';
import 'package:tailor_app/provider/auth/login_provider.dart';
import 'package:tailor_app/provider/auth/signin_provider.dart';
import 'package:tailor_app/view/screens/home_screen.dart';
import 'package:tailor_app/view/screens/auth/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => SignInProvider()),
        ChangeNotifierProvider(create: (create) => LoginProvider()),
        ChangeNotifierProvider(create: (create) => IndividualDialogProvider()),
        ChangeNotifierProvider(create: (create)=>IndividualScreenProvider()),
        ChangeNotifierProvider(create: (create)=>FamilyCreateProvider()),
        ChangeNotifierProvider(create: (create)=> FamilyRecordProvider()),
        ChangeNotifierProvider(create: (create)=>FamilyMemberDialogProvider()),
        ChangeNotifierProvider(create: (create)=> FamilyMemberProvider()),
        ChangeNotifierProvider(create: (create)=>IndividualUpdateProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        home: user != null ? HomeScreen() : const SignupScreen(),
      ),
    );
  }
}

/// Flutter + Firebase + Provider (NO MODEL) - FULL CRUD
/// Features: View + Add Families, Members, Clothes

// ----------------- pubspec.yaml -----------------
// dependencies:
//   flutter:
//   provider:
//   cloud_firestore:
//   firebase_core:

// ----------------- main.dart -----------------
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => FamilyProvider()),
//         ChangeNotifierProvider(create: (_) => MemberProvider()),
//         ChangeNotifierProvider(create: (_) => ClothesProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const HomeScreen(),
//     );
//   }
// }
//
// // ----------------- providers/family_provider.dart -----------------
//
// class FamilyProvider with ChangeNotifier {
//   List<Map<String, dynamic>> _families = [];
//   List<Map<String, dynamic>> get families => _families;
//
//   Future<void> fetchFamilies() async {
//     final snapshot = await FirebaseFirestore.instance.collection('families').get();
//     _families = snapshot.docs.map((doc) {
//       final data = doc.data();
//       data['id'] = doc.id;
//       return data;
//     }).toList();
//     notifyListeners();
//   }
//
//   Future<void> addFamily(String headName) async {
//     await FirebaseFirestore.instance.collection('families').add({'headName': headName});
//     fetchFamilies();
//   }
// }
//
// // ----------------- providers/member_provider.dart -----------------
//
// class MemberProvider with ChangeNotifier {
//   List<Map<String, dynamic>> _members = [];
//   List<Map<String, dynamic>> get members => _members;
//
//   Future<void> fetchMembers(String familyId) async {
//     final snapshot = await FirebaseFirestore.instance.collection('families').doc(familyId).collection('members').get();
//     _members = snapshot.docs.map((doc) {
//       final data = doc.data();
//       data['id'] = doc.id;
//       return data;
//     }).toList();
//     notifyListeners();
//   }
//
//   Future<void> addMember(String familyId, String memberName) async {
//     await FirebaseFirestore.instance.collection('families').doc(familyId).collection('members').add({
//       'name': memberName,
//       'clothes': {},
//     });
//     fetchMembers(familyId);
//   }
// }
//
// // ----------------- providers/clothes_provider.dart -----------------
//
// class ClothesProvider with ChangeNotifier {
//   Map<String, dynamic>? _clothes;
//   Map<String, dynamic>? get clothes => _clothes;
//
//   Future<void> fetchClothes(String familyId, String memberId) async {
//     final doc = await FirebaseFirestore.instance.collection('families').doc(familyId).collection('members').doc(memberId).get();
//     _clothes = doc.data()?['clothes'] ?? {};
//     notifyListeners();
//   }
//
//   Future<void> updateClothes(String familyId, String memberId, Map<String, String> newClothes) async {
//     await FirebaseFirestore.instance.collection('families').doc(familyId).collection('members').doc(memberId).update({
//       'clothes': newClothes,
//     });
//     fetchClothes(familyId, memberId);
//   }
// }
//
// // ----------------- screens/home_screen.dart -----------------
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<FamilyProvider>(context, listen: false).fetchFamilies();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<FamilyProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Families')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(labelText: 'Add Head of Family'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     if (_controller.text.trim().isNotEmpty) {
//                       provider.addFamily(_controller.text.trim());
//                       _controller.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: provider.families.length,
//               itemBuilder: (_, index) {
//                 final fam = provider.families[index];
//                 return ListTile(
//                   title: Text(fam['headName'] ?? ''),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => MembersScreen(familyId: fam['id']),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ----------------- screens/members_screen.dart -----------------
// class MembersScreen extends StatefulWidget {
//   final String familyId;
//   const MembersScreen({super.key, required this.familyId});
//
//   @override
//   State<MembersScreen> createState() => _MembersScreenState();
// }
//
// class _MembersScreenState extends State<MembersScreen> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<MemberProvider>(context, listen: false).fetchMembers(widget.familyId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<MemberProvider>(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Family Members')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(labelText: 'Add Member'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: () {
//                     if (_controller.text.trim().isNotEmpty) {
//                       provider.addMember(widget.familyId, _controller.text.trim());
//                       _controller.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: provider.members.length,
//               itemBuilder: (_, index) {
//                 final mem = provider.members[index];
//                 return ListTile(
//                   title: Text(mem['name'] ?? ''),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => ClothesDetailScreen(
//                         familyId: widget.familyId,
//                         memberId: mem['id'],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ----------------- screens/clothes_detail_screen.dart -----------------
//
// class ClothesDetailScreen extends StatefulWidget {
//   final String familyId;
//   final String memberId;
//   const ClothesDetailScreen({super.key, required this.familyId, required this.memberId});
//
//   @override
//   State<ClothesDetailScreen> createState() => _ClothesDetailScreenState();
// }
//
// class _ClothesDetailScreenState extends State<ClothesDetailScreen> {
//   final shirt = TextEditingController();
//   final pant = TextEditingController();
//   final arm = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ClothesProvider>(context, listen: false).fetchClothes(widget.familyId, widget.memberId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ClothesProvider>(context);
//     final clothes = provider.clothes ?? {};
//     shirt.text = clothes['shirt'] ?? '';
//     pant.text = clothes['pant'] ?? '';
//     arm.text = clothes['arm'] ?? '';
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Clothes Details')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: shirt, decoration: const InputDecoration(labelText: 'Shirt')),
//             TextField(controller: pant, decoration: const InputDecoration(labelText: 'Pant')),
//             TextField(controller: arm, decoration: const InputDecoration(labelText: 'Arm')),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () async {
//                 await provider.updateClothes(widget.familyId, widget.memberId, {
//                   'shirt': shirt.text,
//                   'pant': pant.text,
//                   'arm': arm.text,
//                 });
//               },
//               child: const Text('Save'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
