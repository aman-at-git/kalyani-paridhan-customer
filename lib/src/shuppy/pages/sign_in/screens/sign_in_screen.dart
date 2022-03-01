part of '../sign_in_page.dart';

List<String> allPhoneList = [];

class ShuppySignInScreen extends StatefulWidget {
  const ShuppySignInScreen({Key? key}) : super(key: key);

  @override
  _ShuppySignInScreenState createState() => _ShuppySignInScreenState();
}

class _ShuppySignInScreenState extends State<ShuppySignInScreen> {
  bool _obscureText = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final firestoreInstance = FirebaseFirestore.instance;

  String? sentCode;
  String? enteredOtp;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    getAllPhone();
  }

  void signIn(BuildContext context, {required String email}) {
    if(allPhoneList.contains(email)){
      _verifyPhone();
      setState(() {
        _isLoading = false;
      });
      otpDialog(context);
    } else{
      Fluttertoast.showToast(msg: 'Phone number not registered. Sign up to continue.',
        backgroundColor: Colors.black54,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, state, snapshot) {
      return Scaffold(
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Const.margin),
            children: [
              const SizedBox(height: 100),
              _HeaderSection(
                image: state.isDarkTheme == false
                    ? Images.logoLight
                    : Images.logoDark,
              ),
              const SizedBox(height: 50),
              _BodySection(
                emailController: _emailController,
                passwordController: _passwordController,
                isLoading: _isLoading,
                onForgotPasswordTap: () =>
                    Get.toNamed<dynamic>(ShuppyRoutes.forgotPassword),
                obscureText: _obscureText,
                onObscureTextTap: () {
                  setState(() => _obscureText = !_obscureText);
                },
                onSignInTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState!.validate()) {
                    signIn(context, email: _emailController!.text);
                  }
                },
              ),
              const SizedBox(height: Const.space25),
              _FooterSection(
                onSignUpTap: () => Get.toNamed<dynamic>(ShuppyRoutes.signUp),
                onFacebookTap: () =>
                    showToast(msg: AppLocalizations.of(context)!.facebook),
                onGoogleTap: () =>
                    showToast(msg: AppLocalizations.of(context)!.google),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _verifyPhone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_emailController!.text}',
        verificationCompleted: (PhoneAuthCredential credential) async{
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async{
            if(value.user!=null){
              await Get.offAllNamed<dynamic>(ShuppyRoutes.home);
            }
          });
        },
        timeout: const Duration(seconds: 120),
        verificationFailed: (FirebaseAuthException e){
          Fluttertoast.showToast(msg: e.message.toString());
        },
        codeSent: (String verificationID, int? resendToken){
          sentCode = verificationID;
        },
        codeAutoRetrievalTimeout:(String verificationId){}
    );
  }

  // void _verifyCode() async{
  //   try{
  //     await FirebaseAuth.instance.signInWithCredential(
  //         PhoneAuthProvider.credential(
  //             verificationId: sentCode!,
  //             smsCode: enteredOtp!
  //         )).then((value) async{
  //       if(value.user!=null){
  //         await Get.offAllNamed<dynamic>(ShuppyRoutes.home);
  //       }
  //     });
  //   } catch(e){
  //     FocusScope.of(context).unfocus();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     await Fluttertoast.showToast(msg: 'Entered OTP is incorrect. Please try again.',
  //       backgroundColor: Colors.black54,);
  //   }
  // }

  dynamic otpDialog(BuildContext context) {
    final theme = Theme.of(context);
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
          return AlertDialog(
            backgroundColor: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            content: SizedBox(
              height: 250,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please enter OTP sent to ${_emailController!.text}',
                    style: theme.textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 20,
                    style: const TextStyle(
                        fontSize: 18
                    ),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    onCompleted: (pin) {
                      setState(() {
                        enteredOtp = pin;
                      });
                    },
                    onChanged: (pin){
                      setState(() {
                        enteredOtp = pin;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomOutlinedButton(
                            onTap: () => Get.back<dynamic>(),
                            label: AppLocalizations.of(context)!.back,
                          ),
                        ),
                        const SizedBox(width: 15),
                        if (_isLoading == true)
                          const Expanded(
                            flex: 1,
                              child: CustomLoadingIndicator()
                          )
                        else
                          Expanded(
                            child: CustomElevatedButton(
                            label: 'Submit',
                            color: theme.primaryColor,
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                try{
                                  await FirebaseAuth.instance.signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: sentCode!,
                                          smsCode: enteredOtp!
                                      )).then((value) async{
                                    if(value.user!=null){
                                      await Get.offAllNamed<dynamic>(ShuppyRoutes.home);
                                    }
                                  });
                                } catch(e){
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  await Fluttertoast.showToast(msg: 'Entered OTP is incorrect. Please try again.',
                                    backgroundColor: Colors.black54,);
                                }
                              },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );},
        );
      },
    );
  }

  void getAllPhone(){
    FirebaseFirestore.instance.collection('allUsers').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        allPhoneList.add(doc['phone'].toString());
        print(doc['phone'].toString());
      });
    });
  }

}
