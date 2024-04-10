class BidInfo {
   String playerName;
   String teamName;
   int bidAmount;
   bool isApproved;
   bool isBought;

  BidInfo({required this.playerName, required this.teamName, required this.bidAmount, this.isApproved = false,this.isBought = false});
}

class UserModel {
  final String teamName;
  final String teamOwner;
  final String teamCoach;
  final String username;
  final String password;
  final int teamBudget;

  UserModel({
    required this.teamName,
    required this.teamOwner,
    required this.teamCoach,
    required this.username,
    required this.password,
    required this.teamBudget,
  });
  Map<String, dynamic> toJson() =>
      {'teamName': teamName, 'teamOwner': teamOwner, 'teamCoach': teamCoach, 'userName': username, 'password': password, 'teamBudget': teamBudget};
}

class UserModel1 {
  final String playerName;
  final String playerRole;
  final String jerseyNo;
  final String playerAge;
  final String playerState;
  final String basePrice;

  UserModel1({
    required this.playerName,
    required this.playerRole,
    required this.jerseyNo,
    required this.playerAge,
    required this.playerState,
    required this.basePrice,
  });
}

class StaticData {
  final List<Map<String, dynamic>> BuyerLogin = [
    {
      'userName': 'tushar',
      'password': 'Tushar123',
    },
    {
      'userName': 'hardikMer',
      'password': 'Hardik123',
    },
    {
      'userName': 'tusharPrajapati',
      'password': 'Tushar1234',
    }
  ];
}
