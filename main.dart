import 'dart:convert';

import 'dart:io';

class User {
  late String name;
  late String email;
  static int id = 0;
  dynamic userId = 0;

  User(this.name, this.email) {
    id++;
    userId = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': '$userId',
    };
  }
}

// product class
class Product {
  late String name;
  late String price;
  static int id = 0;
  late int userId;

  Product(this.name, this.price) {
    id++;
    userId = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'id': "$userId",
    };
  }
}

// review
class Review {
  late String review;
  late String productName;
  static int id = 0;
  dynamic userId = 0;

  Review(this.productName, this.review) {
    id++;
    userId = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'review': review,
      'id': '$userId',
    };
  }
}
// user pring data

class UseShown {
  String name;
  String email;
  String id;

  UseShown(this.name, this.email, this.id);
}

class ProductShown {
  String name;
  String price;
  String id;

  ProductShown(this.name, this.price, this.id);
}

class ReviewShown {
  String productName;
  String review;
  String id;

  ReviewShown(this.productName, this.review, this.id);
}

void main() {
  print(
      'Enter a command from the following options: [create class, update id class, show id class, all class, delete id class]');

  var order = stdin.readLineSync() ?? "null";
  var orderItems = order.split(' ');

  if (order.contains("create")) {
    var className = orderItems[1];
    var data = orderItems[2];
    createClass(className, data);
  } else if (order.contains("update")) {
    var id = orderItems[1];
    var className = orderItems[2];
    var data = orderItems[3];
    updateClass(data, className, id);
  } else if (order.contains("show")) {
    var id = orderItems[1];
    var className = orderItems[2];
    showClass(id, className);
  } else if (order.contains("delete")) {
    var id = orderItems[1];
    var className = orderItems[2];
    deleteClass(id, className);
  } else if (order.contains('all')) {
    var className = orderItems[1];
    showAll(className);
  } else {
    print("Invalid order. Please read the instructions carefully.");
  }
}

void createClass(className, data) {
  var dataMap = jsonDecode(data);

  className = className.substring(0, 1).toUpperCase() + className.substring(1);

  if (className == "User") {
    var name = dataMap["name"];
    var email = dataMap["email"];
    var user = User(name, email);
    // check the id ;
    var path = './user.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();
    var data = dataString.split('\n');
    data.length > 0 ? user.userId = data.length : user.userId = 1;
    // ..................
    var mapUser = user.toJson();
    var dataStored = jsonEncode(mapUser);
    file
        .writeAsString('$dataStored \n', mode: FileMode.append, flush: true)
        .then((_) => print('Data appended successfully'))
        .catchError((error) => print('Error appending data: $error'));
  }
  if (className == "Product") {
    var name = dataMap["name"];
    var price = dataMap["price"];
    var product = new Product(name, price);
    // check the id ;
    var path = './product.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();
    var data = dataString.split('\n');
    data.length > 0 ? product.userId = data.length : product.userId = 1;
    // ..................
    var mapUser = product.toJson();
    var dataStored = jsonEncode(mapUser);
    file
        .writeAsString('${dataStored}\n', mode: FileMode.append, flush: true)
        .then((_) => print('Data appended successfully'))
        .catchError((error) => print('Error appending data: $error'));
  }
  if (className == 'Review') {
    var productName = dataMap["productName"];
    var review = dataMap["review"];
    var reviewProduct = new Review(productName, review);
    // check the id ;
    var path = './review.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();
    var data = dataString.split('\n');
    data.length > 0
        ? reviewProduct.userId = data.length
        : reviewProduct.userId = 1;
    // ..................
    var mapUser = reviewProduct.toJson();
    var dataStored = jsonEncode(mapUser);
    file
        .writeAsString('${dataStored}\n', mode: FileMode.append, flush: true)
        .then((_) => print('Data appended successfully'))
        .catchError((error) => print('Error appending data: $error'));
  }

  // Add conditions for other classes
}

void updateClass(data, className, id) {
  var dataMap = jsonDecode(data);

  print(id);
  print(className);
  print(dataMap);
}

void showClass(id, className) {
  className = className.substring(0, 1).toUpperCase() + className.substring(1);

  if (className == "User") {
    var path = './user.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();

    var data = dataString.split('\n');
    var dataMapped = [];

    for (var i = 0; i < data.length; i++) {
      var userDataString = data[i];
      try {
        dynamic userData = json.decode(userDataString);
        var user =
            UseShown(userData['name'], userData['email'], userData['id']);
        dataMapped.add(user);
      } catch (e) {
        print('Error parsing JSON at line ${i + 1}: $e');
      }
    }

    for (var i = 0; i < dataMapped.length; i++) {
      if (dataMapped[i].id == id) {
        print("user data is");
        print(dataMapped[i].id);
        print(dataMapped[i].name);
        print(dataMapped[i].email);
      }
    }
  }
  if (className == "Product") {
    var path = './product.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();

    var data = dataString.split('\n');
    var dataMapped = [];

    for (var i = 0; i < data.length; i++) {
      var userDataString = data[i];
      try {
        dynamic userData = json.decode(userDataString);
        var product =
            ProductShown(userData['name'], userData['price'], userData['id']);
        dataMapped.add(product);
      } catch (e) {
        print('Error parsing JSON at line ${i + 1}: $e');
      }
    }

    for (var i = 0; i < dataMapped.length; i++) {
      if (dataMapped[i].id == id) {
        print("product data is");
        print(dataMapped[i].id);
        print(dataMapped[i].name);
        print(dataMapped[i].price);
      }
    }
  }
  if (className == 'Review') {
    var path = './review.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();

    var data = dataString.split('\n');
    var dataMapped = [];

    for (var i = 0; i < data.length; i++) {
      var reviewData = data[i];
      try {
        dynamic rev = json.decode(reviewData);
        var reviewItem =
            ReviewShown(rev['productName'], rev['review'], rev['id']);
        dataMapped.add(reviewItem);
      } catch (e) {}
    }

    for (var i = 0; i < dataMapped.length; i++) {
      if (dataMapped[i].id == id) {
        print("review data data is");
        print(dataMapped[i].id);
        print(dataMapped[i].productName);
        print(dataMapped[i].review);
      }
    }
  }
}

void deleteClass(id, className) {
//   className = className.substring(0, 1).toUpperCase() + className.substring(1);
//   if (className == "User") {
//     var path = './user.csv';
//     var file = File(path);
//  List<String> lines = file.readAsLinesSync();

//   List<Map<String, dynamic>> data = lines.map((line) {
//     List<String> values = line.split(',');
//     Map<String, dynamic> rowData = {};
//     for (String value in values) {
//       List<String> keyValue = value.split(':');
//       String key = keyValue[0].trim();
//       String val = keyValue[1].trim();
//       rowData[key] = val;
//     }
//     return rowData;
//   }).toList();



// //   var dataReturn = dataMapped.where((el) {
// //   var i = el['id'];
// //   if (i != null) {
// //     var _id = int.parse(i);
// //     return _id != int.parse(id);
// //   }
// //   return false;
// // }).toList();


//   }
  if (className == "Review") {}
  if (className == "Product") {}
}

void showAll(className) {
  className = className.substring(0, 1).toUpperCase() + className.substring(1);

  if (className == "User") {
    var path = './user.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();

    var data = dataString.split('\n');
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
      }
    } else {
      print("there is no data to display");
    }
  }
  if (className == "Product") {
    var path = './product.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();

    var data = dataString.split('\n');
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
      }
    } else {
      print("there is no data to display");
    }
  }
  if (className == 'Review') {
    var path = './review.csv';
    var file = File(path);
    var dataString = file.readAsStringSync();

    var data = dataString.split('\n');
    if (data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
      }
    } else {
      print("there is no data to display");
    }
  }
}
