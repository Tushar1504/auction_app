import 'package:auction_app/Common_button/common_button.dart';
import 'package:auction_app/utils/static_data/static_data.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/constant.dart';

class AddTeamScreen extends StatefulWidget {
  const AddTeamScreen({super.key});

  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  TextEditingController teamNameController = TextEditingController();
  TextEditingController teamOwnerController = TextEditingController();
  TextEditingController teamCoachController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isname = false;
  bool isowner = false;
  bool iscoach = false;
  bool isusername = false;
  bool ispassword = false;

  final storage = GetStorage();

  void addTeam() {
    List<dynamic> addedTeams = storage.read('userModel') ?? [];

    addedTeams.add(UserModel(
      teamName: teamNameController.text,
      teamOwner: teamOwnerController.text,
      teamCoach: teamCoachController.text,
      username: usernameController.text,
      password: passwordController.text,
      teamBudget: 1500000,
    ).toJson());
    teamCoachController.clear();
    teamNameController.clear();
    teamOwnerController.clear();
    usernameController.clear();
    passwordController.clear();
    storage.write('userModel', addedTeams);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> addedTeams = storage.read('userModel') ?? [];
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Add Teams',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Add Teams',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: teamNameController,
                decoration: const InputDecoration(
                  labelText: 'Team Name',
                  hintText: 'Enter Team Name',
                ),
              ),
              TextField(
                controller: teamOwnerController,
                decoration: const InputDecoration(
                  labelText: 'Team Owner',
                  hintText: 'Enter Name',
                ),
              ),
              TextField(
                controller: teamCoachController,
                decoration: const InputDecoration(
                  labelText: 'Team Coach',
                  hintText: 'Enter Name',
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'UserName',
                  hintText: 'Enter Username',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CommonButton(
                  title: 'Add Team',
                  onPressed: () {
                    isname = (teamNameController.text.trim() == '');
                    isowner = (teamOwnerController.text.trim() == '');
                    iscoach = (teamCoachController.text.trim() == '');
                    isusername = (usernameController.text.trim() == '');
                    ispassword = (passwordController.text.trim() == '');
                    (isname == false && isowner == false && iscoach == false && isusername == false && ispassword == false)
                        ? {
                            if (addedTeams.any((element) => element['teamName'].toString().toLowerCase() == teamNameController.text.toLowerCase()))
                              {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                    'Team Name already exists...Create with a new name',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                  showCloseIcon: true,
                                ))
                              }
                            else
                              addTeam()
                          }
                        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                              'Please enter valid Details !!!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            showCloseIcon: true,
                          ));

                    setState(() {});
                  }),
              const SizedBox(
                height: 40,
              ),
              CommonButton(
                  title: 'See Added Teams',
                  onPressed: () {
                    Navigator.pushNamed(context, Strings.addedTeamScreen);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
