import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/static_data/static_data.dart';


class AddedTeamScreen extends StatefulWidget {
  const AddedTeamScreen({super.key});

  @override
  State<AddedTeamScreen> createState() => _AddedTeamScreenState();
}

class _AddedTeamScreenState extends State<AddedTeamScreen> {

  List<dynamic> teams = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchTeams();
    });
  }

  void fetchTeams() {
    List<dynamic> storedTeams = GetStorage().read('userModel')??[];
    setState(() {
      teams = storedTeams;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Teams', style: TextStyle(fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(teams[index]['teamName'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Owner: ${teams[index]['teamOwner']}', style: TextStyle(fontSize: 18),),
                        Text('Coach: ${teams[index]['teamCoach']}', style: TextStyle(fontSize: 18),),
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
