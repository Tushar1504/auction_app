import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/static_data/static_data.dart';

class FinalTeamListScreen extends StatefulWidget {
  const FinalTeamListScreen({super.key});

  @override
  State<FinalTeamListScreen> createState() => _FinalTeamListScreenState();
}

class _FinalTeamListScreenState extends State<FinalTeamListScreen> {
  // List<BidInfo> bidInfo = GetStorage().read('bidInfo') ?? [];
  // List<BidInfo> approvedBids = bidInfo.where((bid) => bid.isApproved).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Final Teams'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // ListView.builder(
          //   itemCount: approvedBids.length,
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(approvedBids[index].teamName, style: TextStyle(fontSize: 19),),
          //           Text(approvedBids[index].playerName),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],),
      ),
    );
  }
}
