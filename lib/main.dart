import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_form/data/Users.dart';
import 'package:user_form/models/User.dart';
import 'package:user_form/views/UserDetail.dart';

void main() {
  runApp(MyApp());
}

/*
 * TASK:
 *  
 * 1. Make an UI with navigation bar, footer, landing page.
 * 2. form page an Input form with valid name, contact number, and email. (Authentication is not required)
 * 3. page will show the given details of 2nd page, with delete btn.
 */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Users(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _userFormKey = new GlobalKey();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  double _kSpacing = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sixthcircle Assignment'),
        actions: [
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (_) => new UserDetail()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Text(
              'User Form',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: _kSpacing),
            Form(
              key: _userFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    validator: (name) {
                      if (name.isEmpty)
                        return 'Please Enter name';
                      else if (name.length < 3) return 'Please Enter full name';
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(hintText: 'Enter Full Name'),
                  ),
                  SizedBox(height: _kSpacing),
                  TextFormField(
                    controller: _phoneController,
                    validator: (phone) {
                      if (phone.isEmpty)
                        return 'Please Enter phone number';
                      else if (num.tryParse(phone) == null)
                        return 'Please Enter valid number';
                      else if (phone.length != 10)
                        return 'please Enter 10 digits';
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: 'Enter Contact Number'),
                  ),
                  SizedBox(height: _kSpacing),
                  TextFormField(
                    controller: _emailController,
                    validator: (email) {
                      if (email.isEmpty)
                        return 'Please Enter email address';
                      else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email))
                        return 'Please Enter valid email address';

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        InputDecoration(hintText: 'Enter Email address'),
                  ),
                  SizedBox(height: _kSpacing),
                  ElevatedButton(
                    onPressed: handleSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                      primary: Colors.blue[800],
                      elevation: 8.0,
                      textStyle: TextStyle(fontSize: 18.0),
                    ),
                    child: Text('ADD'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleSubmit() {
    if (_userFormKey.currentState.validate()) {
      User _user = new User(
        name: _nameController.text,
        email: _emailController.text,
        phone: int.parse(_phoneController.text),
      );

      Provider.of<Users>(context, listen: false).addUser(_user);

      _userFormKey.currentState.reset();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User Added',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
