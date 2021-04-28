import 'package:flutter/material.dart';
import 'package:flutter_stateful_widget/SignIn.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formStateKey = GlobalKey<FormState>(); // tạo GlobalKey cho form
  User user = User(); // tạo object User

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: "Menu",
            onPressed: null,
          ),
          title: Text("SignIn"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search), tooltip: "Search", onPressed: null)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: formStateKey, // gán key cho Form
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your name',
                        labelText: 'name',
                      ),
                      validator: validateTen,
                      onSaved: saveTen,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your Age',
                        labelText: 'Age',
                      ),
                      validator: validateTuoi,
                      onSaved: saveTuoi,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your Phone',
                        labelText: 'Phone',
                      ),
                      validator: validateTen,
                      onSaved: saveTuoi,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Your Email',
                        labelText: 'Email',
                      ),
                      validator: checkValidEmail,
                      onSaved: saveTuoi,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'PassWord',
                        labelText: 'PasWord',
                      ),
                      onSaved: saveTuoi,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Form(
                child: Center(
                  child: Row(children: [
                    FlatButton(
                      child: Text('SignUp'),
                      color: Colors.green[100],
                      textColor: Colors.black,
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (context) => SignIn());
                        Navigator.push(context, route);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    FlatButton(
                      child: Text('Cancle'),
                      color: Colors.red[800],
                      textColor: Colors.black,
                      onPressed: submitForm,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  String checkValidEmail(String value) {
    if (validateEmail(value)) {
      return null;
    } else {
      return 'Email invalid';
    }
  }

  String validateTen(String inputName) {
    if (inputName.isEmpty) {
      // String khác null, đồng nghĩa với validate lỗi, đây cũng chính là nội dung lỗi
      return 'Tên không được trống';
    } else {
      // String trả về là null, đồng nghĩa với validate thành công
      return null;
    }
  }

  String validateTuoi(String inputAge) {
    try {
      if (int.tryParse(inputAge) < 18) {
        return 'Phim cấm trẻ em dưới 18 tuổi';
      } else {
        return null;
      }
    } catch (e) {
      return 'Bạn nhập kiểu gì để nó lỗi vậy. Nhớ nhập số nha';
    }
  }

  void saveTen(String inputName) {
    user.name = inputName; // lưu tên vào biến user
  }

  void saveTuoi(String inputAge) {
    user.age = int.tryParse(inputAge); // lưu tuổi vào biến user
  }

  void submitForm() {
    // Khi form gọi hàm validate thì tất cả các TextFormField sẽ gọi hàm validate.
    // Đó là sức mạnh và lý do cần sử dụng widget Form
    if (formStateKey.currentState.validate()) {
      // hàm validate trả về true là thành công, false là thất bại
      print('Trước khi save: Tên: ${user.name} và tuổi: ${user.age}');
      formStateKey.currentState
          .save(); // khi form gọi hàm save thì tất cả các TextFormField sẽ gọi hàm save
      print('Sau khi save: Tên: ${user.name} và tuổi: ${user.age}');
    } else {
      print('Validate thất bại. Vui lòng thử lại');
    }
  }
}

class User {
  User({this.name, this.age});

  String name;
  int age;
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Product layout demo home page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home Page")),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
          children: <Widget>[
            ProductBox(
                name: "iPhone",
                description: "iPhone is the stylist phone ever",
                price: 1000,
                image: "iphone.jpeg"),
            ProductBox(
                name: "Pixel",
                description: "Pixel is the most featureful phone ever",
                price: 800,
                image: "pixel.jpeg"),
            ProductBox(
                name: "Laptop",
                description: "Laptop is most productive development tool",
                price: 2000,
                image: "laptop.jpeg"),
            ProductBox(
                name: "Tablet",
                description:
                    "Tablet is the most useful device ever for meeting",
                price: 1500,
                image: "tablet.jpeg"),
            ProductBox(
                name: "Pendrive",
                description: "Pendrive is useful storage medium",
                price: 100,
                image: "pendrive.jpg"),
            ProductBox(
                name: "Floppy Drive",
                description: "Floppy drive is useful rescue storage medium",
                price: 20,
                image: "floppydrive.jpg"),
          ],
        ));
  }
}

class RatingBox extends StatefulWidget {
  @override
  _RatingBoxState createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  int _rating = 0;
  void _setRatingAsOne() {
    setState(() {
      _rating = 1;
    });
  }

  void _setRatingAsTwo() {
    setState(() {
      _rating = 2;
    });
  }

  void _setRatingAsThree() {
    setState(() {
      _rating = 3;
    });
  }

  Widget build(BuildContext context) {
    double _size = 20;
    print(_rating);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 1
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 2
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            onPressed: _setRatingAsTwo,
            iconSize: _size,
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 3
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            onPressed: _setRatingAsThree,
            iconSize: _size,
          ),
        ),
      ],
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.name, this.description, this.price, this.image})
      : super(key: key);
  final String name;
  final String description;
  final int price;
  final String image;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Image.asset("assets/images/" + image),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(this.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(this.description),
                          Text("Price: " + this.price.toString()),
                          RatingBox(),
                        ],
                      )))
            ])));
  }
}
