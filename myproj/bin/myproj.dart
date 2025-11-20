import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MenuItem {
  String title;
  double price;

  MenuItem(this.title, this.price);

  String format() {
    return "$title --> $price";
  }

  @override
  String toString() {
    return format();
  }
}

class Pizza extends MenuItem {
  List<String> toppings;

  Pizza(this.toppings, super.title, super.price);

  @override
  String format() {
    var formattedToppings = 'Contains: ';
    for (final t in toppings) {
      formattedToppings = '$formattedToppings $t';
    }

    return '$title --> \$$price \n$formattedToppings';
  }

  @override
  String toString() {
    return 'Instance of Pizza: $title, $price, $toppings';
  }
}

class Collection<T> {
  String name;
  List<T> data;

  Collection(this.name, this.data);

  T randomItem() {
    data.shuffle();

    return data[0];
  }
}

void main() async {
  var name = "mario";
  print(name);
  final age = 25;
  print(age);
  /*	print(age + 10);
 *	print(age - 10);
*/ //	print(age * 10);
  //	print(age / 5);
  //	print(age % 10);
  print("My name is $name and my age is $age");
  int? point;
  print(greet(age: age));

  List<int> score = [50, 70, 20, 99];
  score[0] = 25;
  score.add(100);
  score.add(20);
  score.removeLast();
  print(score.length);
  print(score.indexOf(20));
  score.shuffle();

  Set<String> names = {"mario", "luigi", "peach"};
  names.add("bowser");
  print(names.length);
  print(names);

  for (int i = 0; i < 5; i++) {
    print("The value of i is $i");
  }

  for (int scor in score.where((s) => s > 50)) {
    print("The current score is $scor");
  }

  Map<String, String> planets = {
    "first": "mercury",
    "second": "venus",
    "third": "earth",
    "fourth": "mars",
    "fifth": "jupiter",
  };

  print(planets);
  print(planets["third"]);
  planets["sixth"] = "saturn";
  print(planets.containsKey("third"));
  print(planets.containsValue("saturn"));
  planets.remove("third");
  var noodles = MenuItem('veg noodles', 9.99);
  var pizza = Pizza(["mushrooms", "peppers"], "veg volcano", 15.99);
  print(noodles.format());
  print(pizza.format());
  print(point);

  var roast = MenuItem('veggie roast dinner', 12.49);
  var kebab = MenuItem('plant kebab', 7.49);

  print("$noodles, $pizza, $roast, $kebab");

  var foods = Collection<MenuItem>('Menu items', [
    noodles,
    pizza,
    roast,
    kebab,
  ]);

  var random = foods.randomItem();
  print(random);

  //fetchPost().then((p) {
  //  print(p.title);
  //  print(p.userId);
  //});

  final post = await fetchPost();
  print(post.title);
  print(post.userId);
}

String greet({String? name, required int age}) {
  return "Hello, my name is $name and my age is $age";
}

Future<Post> fetchPost() async {
  //const delay = Duration(seconds: 3);

  //return Future.delayed(delay, () {
  //  return Post('my post', 123);
  //});
  var url = Uri.https('jsonplaceholder.typicode.com', '/posts/1');

  final response = await http.get(url);
  Map<String, dynamic> data = convert.jsonDecode(response.body);
  return Post(data["title"], data["userId"]);
}

class Post {
  String title;
  int userId;

  Post(this.title, this.userId);
}
