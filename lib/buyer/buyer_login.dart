import 'package:auction_app/Common_button/common_button.dart';
import 'package:auction_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/static_data/static_data.dart';

class BuyerLoginScreen extends StatefulWidget {
  const BuyerLoginScreen({super.key});
  @override
  State<BuyerLoginScreen> createState() => _BuyerLoginScreenState();
}

class _BuyerLoginScreenState extends State<BuyerLoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Buyer Login',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  labelText: 'UserName',
                  hintText: 'Enter Username',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CommonButton(
                  title: 'Login',
                  onPressed: () {
                    if (userNameController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty) {
                      List<dynamic> storedUsers = GetStorage().read('userModel') ?? [];
                      UserModel? loggedInTeam;
                      List<UserModel> userModels = storedUsers
                          .map((user) => UserModel(
                              teamName: user['teamName'],
                              teamOwner:  user['teamOwner'],
                              teamCoach:  user['teamCoach'],
                              username:  user['userName'],
                              password:  user['password'],
                              teamBudget:  user['teamBudget']))
                          .toList();
                      bool isValidUser = userModels.any((user) {
                        if (user.username == userNameController.text && user.password == passwordController.text) {
                          loggedInTeam = user;
                        }
                        return user.username == userNameController.text && user.password == passwordController.text;
                      });
                      // if (!isValidUser) {
                      //   isValidUser = StaticData().BuyerLogin.any((element) => element['userName'] == userNameController.text && element['password'] == passwordController.text);}
                      if (isValidUser) {
                        Navigator.pushNamed(context, Strings.playerBidingScreen, arguments: loggedInTeam);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid username or password!'),
                        ));
                      }
                      setState(() {
                        userNameController.clear();
                        passwordController.clear();
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
