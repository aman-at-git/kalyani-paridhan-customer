part of '../sign_up_page.dart';

class ShuppySignUpScreen extends StatefulWidget {
  const ShuppySignUpScreen({Key? key}) : super(key: key);

  @override
  _ShuppySignUpScreenState createState() => _ShuppySignUpScreenState();
}

class _ShuppySignUpScreenState extends State<ShuppySignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureTextConf = true;
  bool _isLoading = false;
  TextEditingController? _fullNameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;

  String? sentCode;
  String? enteredOtp;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _isLoading = false;
  }

  void signUp(BuildContext context, {required String phone}) {
    if(allPhoneList.contains(phone)){
      Fluttertoast.showToast(msg: 'Phone already registered. Please Sign in to continue.',
        backgroundColor: Colors.black54,);
    } else{
      _verifyPhone();
      setState(() {
        _isLoading = false;
      });
      otpDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, state, snapshot) {
      return Scaffold(
        appBar: CustomAppBar(context),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Const.margin),
            children: [
              _HeaderSection(
                image: state.isDarkTheme == false
                    ? Images.logoLight
                    : Images.logoDark,
              ),
              const SizedBox(height: 50),
              _BodySection(
                fullNameController: _fullNameController,
                emailController: _emailController,
                phoneController: _phoneController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                obscureText: _obscureText,
                obscureTextConf: _obscureTextConf,
                isLoading: _isLoading,
                onObscureTextTap: () {
                  setState(() => _obscureText = !_obscureText);
                },
                onObscureConfTextTap: () {
                  setState(() => _obscureTextConf = !_obscureTextConf);
                },
                onSignUpTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState!.validate()) {
                    if(_passwordController!.text != _confirmPasswordController!.text) {
                      Fluttertoast.showToast(msg: 'Passwords do not match',
                        backgroundColor: Colors.black54,);
                    } else {
                      signUp(context, phone: _phoneController!.text);
                    }
                  }
                },
              ),
              const SizedBox(height: Const.space25),
              _FooterSection(
                onSignUpTap: () => Get.back<dynamic>(),
                onFacebookTap: () =>
                    showToast(msg: AppLocalizations.of(context)!.facebook),
                onGoogleTap: () =>
                    showToast(msg: AppLocalizations.of(context)!.google),
              ),
              const SizedBox(height: Const.space25),
              const SizedBox(height: Const.space25),
            ],
          ),
        ),
      );
    });
  }

  void _verifyPhone() async{
    print('sending to ${_phoneController!.text}');
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_phoneController!.text}',
        verificationCompleted: (PhoneAuthCredential credential) async{
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async{
            if(value.user!=null){
              await FirebaseFirestore.instance.collection('allUsers').doc().set(<String, dynamic>{
                'phone':_phoneController!.text,
                'uid': value.user!.uid,
                'name': _fullNameController,
                'email': _emailController
              });
                await Get.offAllNamed<dynamic>(ShuppyRoutes.home);
            }
          });
        },
        timeout: const Duration(seconds: 120),
        verificationFailed: (FirebaseAuthException e){
          Fluttertoast.showToast(msg: e.message.toString());
          print(e.message.toString());
        },
        codeSent: (String verificationID, int? resendToken){
          sentCode = verificationID;
        },
        codeAutoRetrievalTimeout:(String verificationId){}
    );
  }

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
                      'Please enter OTP sent to ${_phoneController!.text}',
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
                                        await FirebaseFirestore.instance.collection('allUsers').doc().set(<String, dynamic>{
                                          'phone':_phoneController!.text,
                                          'uid': value.user!.uid,
                                          'name': _fullNameController!.text,
                                          'email': _emailController!.text
                                        });
                                        await FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(<String, dynamic>{
                                          'phone':_phoneController!.text,
                                          'name': _fullNameController!.text,
                                          'email': _emailController!.text
                                        });
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

}
