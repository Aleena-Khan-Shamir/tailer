import 'package:alma_app/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/dashboard_screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Stream<QuerySnapshot> services =
      FirebaseFirestore.instance.collection('userData').snapshots();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100.h,
            width: 200.w,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10.r),
                color: kPrimaryColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Users',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder(
                        stream: services,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              child: const CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data.size.toString(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      const Icon(
                        Icons.show_chart,
                        color: Colors.white,
                      )
                    ],
                  ),

                  // FloatingActionButton(
                  //   onPressed: () => _createOrUpdate(),
                  //   child: const Icon(Icons.add),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    // Add new product
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);
//   static const String routeName = '/dashboard_screen';
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   // text fields' controllers
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final CollectionReference _userData =
//       FirebaseFirestore.instance.collection('userData');

//   // This function is triggered when the floatting button or one of the edit buttons is pressed
//   // Adding a product if no documentSnapshot is passed
//   // If documentSnapshot != null then update an existing product
//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     String action = 'create';
//     if (documentSnapshot != null) {
//       action = 'update';
//       _emailController.text = documentSnapshot['email'];
//       _passwordController.text = documentSnapshot['password'].toString();
//     }

//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 // prevent the soft keyboard from covering text fields
//                 bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(labelText: 'Name'),
//                 ),
//                 TextField(
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   controller: _passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'paasword',
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   child: Text(action == 'create' ? 'Create' : 'Update'),
//                   onPressed: () async {
//                     final String? email = _emailController.text;
//                     final double? password =
//                         double.tryParse(_passwordController.text);
//                     if (email != null && password != null) {
//                       if (action == 'create') {
//                         // Persist a new product to Firestore
//                         await _userData
//                             .add({"email": email, "password": password});
//                       }

//                       if (action == 'update') {
//                         // Update the product
//                         await _userData
//                             .doc(documentSnapshot!.id)
//                             .update({"email": email, "password": password});
//                       }

//                       // Clear the text fields
//                       _emailController.text = '';
//                       _passwordController.text = '';

//                       // Hide the bottom sheet
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   // Deleteing a product by id
//   Future<void> _deleteProduct(String emailId) async {
//     await _userData.doc(emailId).delete();

//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('You have successfully deleted a email')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       // Using StreamBuilder to display all products from Firestore in real-time
//       body: StreamBuilder(
//         stream: _userData.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['email']),
//                     subtitle: Text(documentSnapshot['password'].toString()),
//                     trailing: SizedBox(
//                       width: 100.w,
//                       child: Row(
//                         children: [
//                           // Press this button to edit a single product
//                           IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () =>
//                                   _createOrUpdate(documentSnapshot)),
//                           // This icon button is used to delete a single product
//                           IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () =>
//                                   _deleteProduct(documentSnapshot.id)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       // Add new product
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _createOrUpdate(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
