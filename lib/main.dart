import 'package:auction_app/added_players/added_player.dart';
import 'package:auction_app/added_teams_screen/added_team_screen.dart';
import 'package:auction_app/admin_screen/add_players/add_players.dart';
import 'package:auction_app/admin_screen/add_teams/add_teams.dart';
import 'package:auction_app/admin_screen/admin.dart';
import 'package:auction_app/admin_screen/final_team.dart';
import 'package:auction_app/buyer/buyer_login.dart';
import 'package:auction_app/buyer/players_biding/players_biding.dart';
import 'package:auction_app/utils/constant.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Strings.adminScreen,
      routes: {
        Strings.adminScreen: (context) => const AdminScreen(),
        Strings.addTeamScreen: (context) => const AddTeamScreen(),
        Strings.addPlayerScreen: (context) => const AddPlayerScreen(),
        Strings.addedTeamScreen: (context) => const AddedTeamScreen(),
        Strings.addedPlayerScreen: (context) => const AddedPlayerScreen(),
        Strings.buyerLoginScreen: (context) => const BuyerLoginScreen(),
        Strings.playerBidingScreen: (context) => const PlayerBidingScreen(),
        Strings.finalTeamListScreen: (context) => const FinalTeamListScreen(),
      }
    );
  }
}

