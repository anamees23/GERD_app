import 'dart:io';
import 'dart:convert';

List<Player> players = [];

void main() async {
  print("hello world");
  final File file = File('db/data.json'); //load the json file
  await readPlayerData(file); //read data from json file

  Player newPlayer = Player(
      //add a new item to data list
      'Samy Brook',
      '31',
      'cooking');

  players.add(newPlayer);

  print(players.length);

  players //convert list data  to json
      .map(
        (player) => player.toJson(),
      )
      .toList();

  file.writeAsStringSync(
      json.encode(players)); //write (the whole list) to json file
}

Future<void> readPlayerData(File file) async {
  String contents = await file.readAsString();
  var jsonResponse = jsonDecode(contents);

  for (var p in jsonResponse) {
    Player player = Player(p['name'], p['age'], p['hobby']);
    players.add(player);
  }
}

class Player {
  late String name;
  late String age;
  late String hobby;

  Player(
    this.name,
    this.age,
    this.hobby,
  );

  Player.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    hobby = json['hobby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['hobby'] = this.hobby;

    return data;
  }
}
