import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AddedPlayerScreen extends StatefulWidget {
  const AddedPlayerScreen({super.key});

  @override
  State<AddedPlayerScreen> createState() => _AddedPlayerScreenState();
}

class _AddedPlayerScreenState extends State<AddedPlayerScreen> {
  List<dynamic> players = [];
  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }

  void fetchPlayers() {
    var storedPlayers = GetStorage().read('players') ?? [];
    setState(() {
      players = storedPlayers;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Players', style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  var player = players[index];
                  return ListTile(
                    title: Text('Name: ${player['playerName']}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Player Role: ${player['playerRole']}', style: TextStyle(fontSize: 18),),
                        Text('Jersey No.: ${player['jerseyNo']}', style: TextStyle(fontSize: 18),),
                        Text('Age: ${player['playerAge']}', style: TextStyle(fontSize: 18),),
                        Text('State: ${player['playerState']}', style: TextStyle(fontSize: 18),),
                        Text('Base Price: ${player['basePrice']}', style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
