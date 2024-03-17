import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'Otp1.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final FirebaseAuth _auth = FirebaseAuth.instance;



  bool _isLoading = false;
  bool _isLoading1 = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();


  String? _nameError;
  String? _emailError;
  String? _numberError;
  bool _isFormValid = false;

  String? _name;
  String? _email;
  String? _number;


  void _validateForm() {
    setState(() {
      _nameError = _validateName(nameController.text.trim());
      _emailError = _validateEmail(emailController.text.trim());
      _numberError = _validateNumber(numberController.text.trim());
      _isFormValid =
          _nameError == null && _emailError == null && _numberError == null;

      if (_isFormValid) {
        _name = nameController.text.trim();
        _email = emailController.text.trim();
        _number = numberController.text.trim();
      }
    });
  }

  void _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('number', isEqualTo: _number)
          .where('email' , isEqualTo: _email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User already exists. Please login.'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } else {
        DocumentReference newUserDocRef = await FirebaseFirestore.instance.collection('users').add({
          'name': _name,
          'email': _email,
          'number': _number,
        });


        setState(() {
          _isLoading = false;
        });

        String documentUID = newUserDocRef.id;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Otp1(mobileNumber: numberController.text, Uid: documentUID,)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), duration: Duration(seconds: 2)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }




  void _navigateToHome(BuildContext context) {
    _validateForm();

    if (_isFormValid) {
      _registerUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields correctly.'),duration: Duration(seconds: 2),),
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }

    if (value.contains(' ')) {
      return 'Please clear blank space';
    }

    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }

    return null;
  }

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    TextStyle defaultStyle = TextStyle(color: Colors.black, fontFamily: "crete");
    TextStyle linkStyle = TextStyle(color: Color(0xfffbb2f4),fontFamily: "crete");

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Image(image: AssetImage("assets/signup.png"),width: double.infinity,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Create New Account",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: 'crete',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _nameError != null ? Colors.red : Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      labelText: 'Enter your name',
                      labelStyle: TextStyle(
                          color: _nameError != null ? Colors.red : Colors.black,
                          fontFamily: "crete"
                      ),
                      floatingLabelStyle: TextStyle(
                          color: _nameError != null ? Colors.red : Colors.black,
                          fontFamily: "crete"
                      ),
                      errorText: _nameError,
                      suffixIcon: Icon(Icons.person),
                      suffixIconColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.focused) ? (_nameError != null ? Colors.red : Colors.black)
                          : Colors.black,
                      )
                  ),
                  onChanged: (value) {
                    setState(() {
                      _nameError = _validateName(value);
                    });
                  },
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _emailError != null ? Colors.red : Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: _emailError != null ? Colors.red : Colors.black,
                          fontFamily: "crete"
                      ),
                      floatingLabelStyle: TextStyle(
                          color: _emailError != null ? Colors.red : Colors.black,
                          fontFamily: "crete"
                      ),
                      errorText: _emailError,
                      suffixIcon: Icon(Icons.email),
                      suffixIconColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.focused) ? (_emailError != null ? Colors.red : Colors.black)
                          : Colors.black,
                      )
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailError = _validateEmail(value);
                    });
                  },
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: numberController,
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      counterText: "",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _numberError != null ? Colors.red : Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(
                          color: _numberError != null ? Colors.red : Colors.black,
                          fontFamily: "crete"
                      ),
                      floatingLabelStyle: TextStyle(
                          color: _numberError != null ? Colors.red : Colors.black,
                          fontFamily: "crete"
                      ),
                      errorText: _numberError,
                      suffixIcon: Icon(Icons.phone),
                      suffixIconColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.focused) ? (_numberError != null ? Colors.red : Colors.black)
                          : Colors.black,
                      )
                  ),
                  onChanged: (value) {
                    setState(() {
                      _numberError = _validateNumber(value);
                    });
                  },
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () => _navigateToHome(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfffbb2f4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    minimumSize: Size(50.0, 50.0),
                  ),
                  child: _isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "crete",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: defaultStyle,
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                        ),
                        TextSpan(
                          style: linkStyle,
                          text: " Login here",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
