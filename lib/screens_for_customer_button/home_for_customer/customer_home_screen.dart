import 'package:alma_app/screens_for_customer_button/home_for_customer/post.dart';
import 'package:alma_app/screens_for_customer_button/home_for_customer/profile_screen.dart';
import 'package:alma_app/screens_for_customer_button/home_for_customer/searchbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../firebase_services/firestoremethod.dart';

class CustomerHomeScreen extends StatefulWidget {
  CustomerHomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home_for_customer';

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  late BannerAd _bannerAd;

  bool _isAdLoaded = false;
  late String searchString;

  @override
  void initState() {
    searchString = '';
    super.initState();
    _initBannerAd();
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: BannerAd.testAdUnitId,
      listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, err) {}),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  void setSearchString(String value) => setState(() {
        searchString = value;
      });
  @override
  Widget build(BuildContext context) {
    print('Customer Home Screen');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SearchBar(
          onChanged: setSearchString,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ProfileScreenForCustomer()));
            },
            icon: const Icon(CupertinoIcons.person_circle_fill),
            iconSize: 30,
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirestoreMethod.getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => PostCardForCustomer(
              snap: snapshot.data!.docs[index],
            ),
          );
        },
      ),
      bottomNavigationBar: _isAdLoaded
          ? Container(
              height: _bannerAd.size.height.toDouble(),
              width: _bannerAd.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
    );
  }

  // _signOut() async {
  //   await AppConstant().auth!.signOut();
  // }
}
