import 'package:auction_app/Common_button/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/constant.dart';

class AddPlayerScreen extends StatefulWidget {
  const AddPlayerScreen({super.key});

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  TextEditingController playerNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController playerNoController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isplayerName = false;
  bool isrole = false;
  bool isplayerno = false;
  bool isage = false;
  bool isstate = false;
  bool isprice = false;

  void addPlayer() {
    final storage = GetStorage();
    List<dynamic> players = storage.read('players') ?? [];

    players.add({
      'playerName': playerNameController.text,
      'playerRole': roleController.text,
      'jerseyNo': playerNoController.text,
      'playerAge': ageController.text,
      'playerState': stateController.text,
      'basePrice': priceController.text,
    });
    playerNameController.clear();
    priceController.clear();
    playerNoController.clear();
    roleController.clear();
    ageController.clear();
    stateController.clear();
    storage.write('players', players);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'Players',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Add Players',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: playerNameController,
                decoration: InputDecoration(
                  labelText: 'Player Name',
                  hintText: 'Enter Name',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: 'Player Role',
                  hintText: 'Enter role',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: playerNoController,
                decoration: InputDecoration(
                  labelText: 'Jersey no.',
                  hintText: 'Enter no.',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Player Age',
                  hintText: 'Enter Age',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: stateController,
                decoration: InputDecoration(
                  labelText: 'Player State',
                  hintText: 'Enter State',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Base Price',
                  hintText: 'Enter Price',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 30,
              ),
              CommonButton(
                  title: 'Add Player',
                  onPressed: () {
                    isplayerName = (playerNameController.text.isEmpty);
                    isrole = (roleController.text.isEmpty);
                    isplayerno = (playerNoController.text.isEmpty);
                    isage = (ageController.text.isEmpty);
                    isstate = (stateController.text.isEmpty);
                    isprice = (priceController.text.isEmpty);
                    (isplayerName == false && isrole == false && isplayerno == false && isage == false && isstate == false && isprice == false)
                        ? addPlayer()
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
              SizedBox(
                height: 40,
              ),
              CommonButton(
                  title: 'Added Players',
                  onPressed: () {
                    Navigator.pushNamed(context, Strings.addedPlayerScreen);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
