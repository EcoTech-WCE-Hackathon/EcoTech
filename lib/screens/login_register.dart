import 'dart:ui';

import 'package:ecotech/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool _isLoginPasswordHidden = true;
  bool _isRegisterPasswordHidden = true;
  bool _isRegisterConfirmPasswordHidden = true;

  bool isAdmin = false;
  bool isDeliveryBoy = false;

  bool isLoginLoading = false;
  bool isRegisterLoading = false;

  late double _loginOpacity;
  late double _registerOpacity;

  var _loginHeight;
  var _loginWidth;
  var _registerHeight;
  var _registerWidth;

  double screenHeight = window.physicalSize.height / window.devicePixelRatio;
  double screenWidth = window.physicalSize.width / window.devicePixelRatio;

  bool loginEmailValidate = false;
  bool loginPasswordValidate = false;
  bool registerFirstNameValidate = false;
  bool registerLastNameValidate = false;
  bool registerPhoneValidate = false;
  bool registerUsernameValidate = false;
  bool registerEmailValidate = false;
  bool registerPasswordValidate = false;
  bool registerConfirmPasswordValidate = false;
  bool registerAddressValidate = false;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController registerFirstNameController = TextEditingController();
  TextEditingController registerLastNameController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();
  TextEditingController registerUsernameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmPasswordController = TextEditingController();
  TextEditingController registerAddressController = TextEditingController();

  late SharedPreferences prefs;

  late FocusNode focus;

  late FToast fToast;

  @override
  void dispose() {
    super.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerFirstNameController.dispose();
    registerLastNameController.dispose();
    registerPhoneController.dispose();
    registerUsernameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    registerAddressController.dispose();
    focus.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loginOpacity = 1.0;
    _registerOpacity = 0.0;

    _loginWidth = screenWidth;
    _registerWidth = screenWidth;
    _loginHeight = screenHeight * 0.60;
    _registerHeight = 0.0;

    focus = FocusNode();

    fToast = FToast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brandColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedOpacity(
              opacity: _registerOpacity,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    'Register!',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sign up to continue',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.easeInOut,
                    height: _registerHeight,
                    width: _registerWidth,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x20000000),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, -4),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              'Create a new account',
                              style: GoogleFonts.poppins(
                                color: AppColors.brandColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          buildTextField(
                            context,
                            'First Name',
                            Icons.person,
                            TextInputType.name,
                            registerFirstNameController,
                            TextCapitalization.words,
                            registerFirstNameValidate,
                            TextInputAction.next,
                          ),
                          buildTextField(
                            context,
                            'Last Name',
                            Icons.person,
                            TextInputType.name,
                            registerLastNameController,
                            TextCapitalization.words,
                            registerLastNameValidate,
                            TextInputAction.next,
                          ),
                          buildTextField(
                            context,
                            'Mobile Number',
                            Icons.phone,
                            TextInputType.phone,
                            registerPhoneController,
                            TextCapitalization.none,
                            registerPhoneValidate,
                            TextInputAction.next,
                          ),
                          buildTextField(
                            context,
                            'Username',
                            Icons.alternate_email,
                            TextInputType.name,
                            registerUsernameController,
                            TextCapitalization.words,
                            registerUsernameValidate,
                            TextInputAction.next,
                          ),
                          buildTextField(
                            context,
                            'Email',
                            Icons.mail,
                            TextInputType.emailAddress,
                            registerEmailController,
                            TextCapitalization.none,
                            registerEmailValidate,
                            TextInputAction.next,
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 60,
                                  child: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    controller: registerPasswordController,
                                    obscureText: _isRegisterPasswordHidden,
                                    decoration: InputDecoration(
                                      errorText:
                                          registerPasswordValidate ? 'Field can\'t be empty' : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color: Colors.red,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                      suffix: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isRegisterPasswordHidden =
                                                  !_isRegisterPasswordHidden;
                                            });
                                          },
                                          child: Icon(
                                            _isRegisterPasswordHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    controller: registerConfirmPasswordController,
                                    obscureText: _isRegisterConfirmPasswordHidden,
                                    decoration: InputDecoration(
                                      errorText: registerConfirmPasswordValidate
                                          ? 'Field can\'t be empty'
                                          : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Confirm Password',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                      suffix: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isRegisterConfirmPasswordHidden =
                                                  !_isRegisterConfirmPasswordHidden;
                                            });
                                          },
                                          child: Icon(
                                            _isRegisterConfirmPasswordHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          buildTextField(
                            context,
                            'Address',
                            Icons.location_on_rounded,
                            TextInputType.streetAddress,
                            registerAddressController,
                            TextCapitalization.sentences,
                            registerAddressValidate,
                            TextInputAction.done,
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            child: isRegisterLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: AppColors.brandColor,
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      String fname;
                                      String lname;
                                      String name;
                                      String address;
                                      String username;
                                      String phone;
                                      String email;
                                      String password;
                                      String confirmPassword;

                                      setState(() {
                                        isRegisterLoading = true;
                                        fname = registerFirstNameController.text;
                                        lname = registerLastNameController.text;
                                        name = '$fname $lname';
                                        phone = registerPhoneController.text;
                                        username = registerUsernameController.text;
                                        email = registerEmailController.text;
                                        password = registerPasswordController.text;
                                        confirmPassword = registerConfirmPasswordController.text;
                                        address = registerAddressController.text;

                                        fname.isEmpty
                                            ? registerFirstNameValidate = true
                                            : registerFirstNameValidate = false;
                                        lname.isEmpty
                                            ? registerLastNameValidate = true
                                            : registerLastNameValidate = false;
                                        phone.isEmpty
                                            ? registerPhoneValidate = true
                                            : registerPhoneValidate = false;
                                        email.isEmpty
                                            ? registerEmailValidate = true
                                            : registerEmailValidate = false;
                                        username.isEmpty
                                            ? registerUsernameValidate = true
                                            : registerUsernameValidate = false;
                                        password.isEmpty
                                            ? registerPasswordValidate = true
                                            : registerPasswordValidate = false;
                                        confirmPassword.isEmpty
                                            ? registerConfirmPasswordValidate = true
                                            : registerConfirmPasswordValidate = false;
                                        address.isEmpty
                                            ? registerAddressValidate = true
                                            : registerAddressValidate = false;
                                      });
                                    },

                                    // TODO: Add register logic
                                    child: Text(
                                      'Register',
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        letterSpacing: 1.25,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.brandColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _registerHeight = 0.0;
                                    _registerOpacity = 0.0;
                                    _loginHeight = screenHeight * 0.60;
                                    _loginOpacity = 1.0;
                                  });
                                },
                                child: Text(
                                  'LOGIN',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.brandColor),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: screenHeight * 0.05,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              opacity: _loginOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    'Welcome!',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Login to your account to start shopping',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.easeInOut,
                    height: _loginHeight,
                    width: _loginWidth,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x20000000),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, -4),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50, bottom: 20),
                            child: Text(
                              'Login to Continue',
                              style: GoogleFonts.poppins(
                                color: AppColors.brandColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Icon(
                                    Icons.mail,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    controller: loginEmailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                      errorText:
                                          loginEmailValidate ? 'Field can\'t be empty' : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Icon(
                                    Icons.lock,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    textInputAction: TextInputAction.done,
                                    textCapitalization: TextCapitalization.none,
                                    style: GoogleFonts.montserrat(),
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: loginPasswordController,
                                    obscureText: _isLoginPasswordHidden,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText:
                                          loginPasswordValidate ? 'Field can\'t be empty' : null,
                                      errorStyle: GoogleFonts.montserrat(
                                        color: Colors.red,
                                      ),
                                      hintText: 'Password',
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Colors.black,
                                      ),
                                      suffix: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _isLoginPasswordHidden = !_isLoginPasswordHidden;
                                            });
                                          },
                                          child: Icon(
                                            _isLoginPasswordHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth,
                            height: 60,
                            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            child: isLoginLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: AppColors.brandColor,
                                      valueColor: const AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      String email;
                                      String password;

                                      setState(() {
                                        isLoginLoading = true;
                                        email = loginEmailController.text;
                                        password = loginPasswordController.text;

                                        email.isEmpty
                                            ? loginEmailValidate = true
                                            : loginEmailValidate = false;
                                        password.isEmpty
                                            ? loginPasswordValidate = true
                                            : loginPasswordValidate = false;
                                      });
                                    },
                                    child: Text(
                                      'Login',
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.25,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.brandColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _loginHeight = 0.0;
                                    _loginOpacity = 0.0;
                                    _registerHeight = screenHeight * 0.60;
                                    _registerOpacity = 1.0;
                                  });
                                },
                                child: Text(
                                  'REGISTER',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.brandColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTextField(
    BuildContext context,
    String hint,
    IconData icon,
    TextInputType type,
    TextEditingController controller,
    TextCapitalization caps,
    bool validate,
    TextInputAction action,
  ) {
    return Container(
      width: screenWidth,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: TextField(
              textInputAction: action,
              textCapitalization: caps,
              style: GoogleFonts.montserrat(),
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(
                errorText: validate ? 'Field can\'t be empty' : null,
                errorStyle: GoogleFonts.montserrat(
                  color: Colors.red,
                ),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.parse(s) != null;
  }
}
