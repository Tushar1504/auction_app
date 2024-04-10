import 'package:auction_app/Common_button/common_button.dart';
import 'package:auction_app/utils/static_data/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../buyer/players_biding/players_biding.dart';
import '../utils/constant.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  void updateBidInfoInStorage(List<BidInfo> bids) {
    GetStorage().write('bidInfo', bids);
  }

  void updatePlayerApprovalStatus(String playerName) {
    List<dynamic> players = GetStorage().read('players') ?? [];

    for (var player in players) {
      if (player['playerName'] == playerName) {
        player['isApproved'] = true;
        break;
      }
    }
    players.removeWhere((player) => player['playerName'] == playerName);
    GetStorage().write('players', players);
  }

  @override
  Widget build(BuildContext context) {
    List<BidInfo> bidInfo = GetStorage().read('bidInfo') ?? [];
    List<BidInfo> approvedBids = bidInfo.where((bid) => bid.isApproved).toList();
    List<dynamic> teams = GetStorage().read('userModel') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CommonButton(
                  title: 'Add Team',
                  onPressed: () {
                    Navigator.pushNamed(context, Strings.addTeamScreen);
                  }),
              const SizedBox(
                height: 20,
              ),
              CommonButton(
                  title: 'Add Players',
                  onPressed: () {
                    Navigator.pushNamed(context, Strings.addPlayerScreen);
                  }),
              const SizedBox(
                height: 20,
              ),
              CommonButton(
                  title: 'Buyer',
                  onPressed: () {
                    print('object');
                    Navigator.pushNamed(context, Strings.buyerLoginScreen).then((value) {
                      setState(() {});
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '---------------------> Bid History <---------------------',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              ListView.builder(
                  itemCount: bidInfo.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Column(
                          children: [
                            Text(
                              bidInfo[index].teamName,
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text(bidInfo[index].playerName),
                            Text(bidInfo[index].bidAmount.toString()),
                            const SizedBox(
                              height: 5,
                            ),
                            (bidInfo[index].isApproved == true || bidInfo[index].isBought == true)
                                ? const SizedBox.shrink()
                                : CommonButton(
                                    title: 'Approve',
                                    onPressed: () {
                                      setState(() {
                                        bidInfo[index].isApproved = true;
                                        for (int i = 0; i < bidInfo.length; i++) {
                                          if (bidInfo[i].playerName == bidInfo[index].playerName) {
                                            bidInfo[i].isBought = true;
                                          }
                                        }
                                        bidInfo[index].isBought = true;
                                        updateBidInfoInStorage(bidInfo);
                                        updatePlayerApprovalStatus(bidInfo[index].playerName);

                                        for (var element in teams) {
                                          if(element['teamName'] == bidInfo[index].teamName) {
                                            element['teamBudget'] = element['teamBudget'] - bidInfo[index].bidAmount;
                                          }
                                        }
                                      });
                                      GetStorage().write('userModel', teams);
                                    }),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '------------------> Final Team <------------------',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              ListView.builder(
                  itemCount: teams.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            teams[index]['teamName'],
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          itemCount: approvedBids.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, innerIndex) {
                            return teams[index]['teamName'] == approvedBids[innerIndex].teamName
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(approvedBids[innerIndex].playerName),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
