import 'package:auction_app/Common_button/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/static_data/static_data.dart';

class PlayerBidingScreen extends StatefulWidget {
  const PlayerBidingScreen({Key? key}) : super(key: key);
  @override
  State<PlayerBidingScreen> createState() => _PlayerBidingScreenState();
}

List<dynamic> players = [];

class _PlayerBidingScreenState extends State<PlayerBidingScreen> {
  TextEditingController balanceController = TextEditingController();
  List<int> skipPlayer = [];
  List<BidInfo> bidInfo = GetStorage().read('bidInfo') ?? [];
  Map<int, Map<String, dynamic>> biddingInfo = {};
  Map<int, String> highestBidTeam = {};
  void placeBid(int playerIndex, int bidAmount, String teamName) {
    setState(() {
      if (!biddingInfo.containsKey(playerIndex) || bidAmount > biddingInfo[playerIndex]!['bidAmount']) {
        biddingInfo[playerIndex] = {'bidAmount': bidAmount};
        highestBidTeam[playerIndex] = teamName;
      }
    });
  }

  late List<bool> skippedItems;

  @override
  void initState() {
    super.initState();
    fetchPlayers();
    skippedItems = List.generate(players.length, (index) => false);
  }

  void fetchPlayers() {
    var storedPlayers = GetStorage().read('players') ?? [];
    setState(() {
      players = storedPlayers;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel loggedInTeam = ModalRoute.of(context)!.settings.arguments as UserModel;
    int balance = loggedInTeam.teamBudget;
    int remainingBalance = loggedInTeam.teamBudget;
    void alertbox(int index) {
      final int basePrice = int.parse(players[index]['basePrice']);
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, newState) {
            return AlertDialog(
              title: const Text("Bidding Amount"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available Budget: $remainingBalance', style: const TextStyle(fontWeight: FontWeight.w500)),
                    // Text(balance.toString(), style: TextStyle(fontWeight: FontWeight.w500)),
                    TextField(
                      controller: balanceController,
                      decoration: const InputDecoration(
                        labelText: 'Enter the bidding Amount',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value != '')
                          newState(() {
                            remainingBalance = loggedInTeam.teamBudget - int.parse(value);
                          });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.grey.shade500),
                      color: Colors.grey.shade500,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    int bidAmount = int.parse(balanceController.text);
                    if (bidAmount < basePrice) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Bid amount must be greater than or equal to the base price.'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (bidAmount > balance) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You cannot bid more than your available balance.'),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }
                    if (bidInfo.isNotEmpty && bidAmount < bidInfo.last.bidAmount) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('enter more bid'),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      String teamName = loggedInTeam.teamName;
                      placeBid(index, bidAmount, teamName);

                      if (bidInfo.any((element) {
                        return (element.playerName == players[index]['playerName'] && element.teamName == loggedInTeam.teamName);
                      })) {
                        setState(() {
                          balance -= bidAmount;
                          bidInfo.removeWhere(
                              (element) => (element.playerName == players.first['playerName'] && element.teamName == loggedInTeam.teamName));
                          bidInfo.add(BidInfo(playerName: players.first['playerName'], teamName: loggedInTeam.teamName, bidAmount: bidAmount));
                          GetStorage().write('bidInfo', bidInfo);
                        });
                      } else {
                        setState(() {
                          balance -= bidAmount;
                          bidInfo.add(BidInfo(playerName: players[index]['playerName'], teamName: loggedInTeam.teamName, bidAmount: bidAmount));
                          GetStorage().write('bidInfo', bidInfo);
                        });
                      }
                    }
                    balanceController.clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.blue),
                      color: Colors.blue,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      child: Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Players Bidding',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                var player = players.first;
                bool isSkip = skipPlayer.contains(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: isSkip ? Colors.grey : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${player['playerName']}',
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text('Player Role: ${player['playerRole']}', style: const TextStyle(fontSize: 18)),
                          Text('Jersey No.: ${player['jerseyNo']}', style: const TextStyle(fontSize: 18)),
                          Text('Age: ${player['playerAge']}', style: const TextStyle(fontSize: 18)),
                          Text('State: ${player['playerState']}', style: const TextStyle(fontSize: 18)),
                          Text('Base Price: ${player['basePrice']}', style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 10),
                          if (biddingInfo.containsKey(index))
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Highest Bid: ${biddingInfo[index]!['bidAmount']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Highest Bid Team: ${loggedInTeam.teamName}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              CommonButton(
                                title: 'Bid',
                                onPressed: skippedItems[index]
                                    ? null
                                    : () {
                                        alertbox(index);
                                      },
                              ),
                              const SizedBox(width: 10),
                              CommonButton(
                                title: 'Skip',
                                onPressed: () {
                                  setState(() {
                                    // skipPlayer.add(index);
                                    setState(() {
                                      skippedItems[index] = true;
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
