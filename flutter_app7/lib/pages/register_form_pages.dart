import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app7/model/model.dart';
import 'package:flutter_app7/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final List<String> _countries = [
    "Russia",
    "Ukraine",
    "Belarus",
    "Kahzakstan"
  ];

  String? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Register Form"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full Name *",
                hintText: "How do guys calling you?",
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                  labelText: "Phone Number *",
                  hintText: "Whats your phone?",
                  helperText: "Phone Format: (XXX)XXX-XXXX",
                  prefixIcon: Icon(Icons.call),
                  suffixIcon: GestureDetector(
                    onLongPress: () {
                      _phoneController.clear();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                //FilteringTextInputFormatter.digitsOnly,
                //FilteringTextInputFormatter(RegExp(r'^[()/d -][1-15]$'),)
              ],
              // validator: (value) => _validatePhoneNumber(value)
              //     ? null
              //     : "Phone number must be entered as (XXX) XXX-XXXX",
              onSaved: (value) => newUser.phone = value,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email Address",
                hintText: "Enter your Email",
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              onSaved: (value) => newUser.email = value,
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (String? country) {
                print(country);
                setState(
                  () {
                    _selectedCountry = country;
                    newUser.country = country;
                  },
                );
              },
              value: _selectedCountry,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: "Your Country",
              ),
              validator: (val) {
                return val == null ? "Please choose your country" : null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: "Live story",
                hintText: "Tell about you",
                helperText: "Keep it short is just a demo",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) => newUser.story = value,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              maxLength: 8,
              obscureText: _hidePass,
              decoration: InputDecoration(
                  labelText: "Password *",
                  hintText: "Enter your password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  icon: Icon(Icons.security)),
              validator: _validatePassword,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidePass,
              decoration: InputDecoration(
                  labelText: "Confirm Password*",
                  hintText: "Confirm your password",
                  icon: Icon(Icons.border_color)),
              validator: _validatePassword,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Submit Form"),
              style: ElevatedButton.styleFrom(primary: Colors.teal),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print('Name: ${_nameController.text}');
      print('Phone: ${_passController.text}');
      print('Email: ${_emailController.text}');
      print('Country: ${_selectedCountry}');
      print('Story: ${_storyController.text}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
          "Check your form",
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
    ;
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z]+$');
    if (value!.isEmpty) {
      return "Name is requred";
    } else if (!_nameExp.hasMatch(value)) {
      return "Please enter alphabetical characters.";
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String? input) {
    final _phoneExp = RegExp(r'/(/d/d/d/)/d/d/d/-/d/d/d/d/$');
    return _phoneExp.hasMatch(input!);
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Cannot be empty";
    } else if (!_emailController.text.contains("@")) {
      return "Invalid email address";
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text.length < 8) {
      return "Must be 8 or more charecters";
    } else if (_confirmPassController.text != _passController.text) {
      return "Passwords does not match";
    } else {
      return null;
    }
  }

  void _showMessage(String message) {
    //_scaffoldKey.currentState.showSnackBar(    );
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter somethong here to display on snackbar")));
  }

  void _showDialog({String? name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Registration successful",
                style: TextStyle(
                  color: Colors.red,
                )),
            content: Text("$name is now a verified register form",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserInfoPage(
                                userInfo: newUser,
                              )));
                },
                child: Text(
                  "Verified",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                  ),
                ),
              )
            ],
          );
        });
  }
}
