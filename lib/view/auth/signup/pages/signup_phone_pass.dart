import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:clean_hub/service/app_string_service.dart';
import 'package:clean_hub/service/auth_services/signup_service.dart';
import 'package:clean_hub/service/rtl_service.dart';
import 'package:clean_hub/view/auth/signup/signup_helper.dart';
import 'package:clean_hub/view/utils/common_helper.dart';
import 'package:clean_hub/view/utils/constant_colors.dart';
import 'package:clean_hub/view/utils/constant_styles.dart';
import 'package:clean_hub/view/utils/others_helper.dart';

class SignupPhonePass extends StatefulWidget {
  const SignupPhonePass(
      {Key? key,
      this.passController,
      this.fullNameController,
      this.userNameController,
      this.emailController,
      this.repeatPassController})
      : super(key: key);

  final fullNameController;
  final userNameController;
  final emailController;
  final passController;
  final repeatPassController;

  @override
  _SignupPhonePassState createState() => _SignupPhonePassState();
}

class _SignupPhonePassState extends State<SignupPhonePass> {
  late bool _newpasswordVisible;
  late bool _repeatnewpasswordVisible;

  @override
  void initState() {
    super.initState();
    _newpasswordVisible = false;
    _repeatnewpasswordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Consumer<SignupService>(
        builder: (context, provider, child) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Phone number field
                CommonHelper().labelCommon(asProvider.getString("Phone")),
                Consumer<RtlService>(
                  builder: (context, rtlP, child) => IntlPhoneField(
                    countries: const [
                      Country(
                        name: "Egypt",
                        nameTranslations: {
                          "sk": "Egypt",
                          "se": "Egypt",
                          "pl": "Egipt",
                          "no": "Egypt",
                          "ja": "エジプト",
                          "it": "Egitto",
                          "zh": "埃及",
                          "nl": "Egypt",
                          "de": "Ägypt",
                          "fr": "Égypte",
                          "es": "Egipt",
                          "en": "Egypt",
                          "pt_BR": "Egito",
                          "sr-Cyrl": "Египат",
                          "sr-Latn": "Egipat",
                          "zh_TW": "埃及",
                          "tr": "Mısır",
                          "ro": "Egipt",
                          "ar": "مصر",
                          "fa": "مصر",
                          "yue": "埃及"
                        },
                        flag: "🇪🇬",
                        code: "EG",
                        dialCode: "20",
                        minLength: 10,
                        maxLength: 10,
                      ),
                    ],
                    decoration: SignupHelper().phoneFieldDecoration(),
                    searchText: asProvider.getString("Search country"),
                    initialCountryCode: provider.countryCode,
                    disableLengthCheck: true,
                    textAlign: rtlP.direction == 'ltr'
                        ? TextAlign.left
                        : TextAlign.right,
                    onChanged: (phone) {
                      provider.setCountryCode(phone.countryISOCode);

                      provider.setPhone(phone.number);
                    },
                  ),
                ),

                sizedBoxCustom(20),

                //New password =========================>
                CommonHelper().labelCommon(asProvider.getString("Password")),

                Container(
                    margin: const EdgeInsets.only(bottom: 19),
                    decoration: BoxDecoration(
                        // color: const Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: widget.passController,
                      textInputAction: TextInputAction.next,
                      obscureText: !_newpasswordVisible,
                      style: const TextStyle(fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return asProvider
                              .getString("Please enter your password");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 22.0,
                                width: 40.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icons/lock.png'),
                                      fit: BoxFit.fitHeight),
                                ),
                              ),
                            ],
                          ),
                          suffixIcon: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _newpasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _newpasswordVisible = !_newpasswordVisible;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ConstantColors().greyFive),
                              borderRadius: BorderRadius.circular(9)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().primaryColor)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().warningColor)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().primaryColor)),
                          hintText: asProvider.getString("Enter password"),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 18)),
                    )),

                //Repeat New password =========================>
                CommonHelper()
                    .labelCommon(asProvider.getString("Repeat password")),

                Container(
                    margin: const EdgeInsets.only(bottom: 19),
                    decoration: BoxDecoration(
                        // color: const Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: widget.repeatPassController,
                      textInputAction: TextInputAction.next,
                      obscureText: !_repeatnewpasswordVisible,
                      style: const TextStyle(fontSize: 14),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return asProvider
                              .getString("Please retype your password");
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 22.0,
                                width: 40.0,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icons/lock.png'),
                                      fit: BoxFit.fitHeight),
                                ),
                              ),
                            ],
                          ),
                          suffixIcon: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _repeatnewpasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                              size: 22,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _repeatnewpasswordVisible =
                                    !_repeatnewpasswordVisible;
                              });
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ConstantColors().greyFive),
                              borderRadius: BorderRadius.circular(9)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().primaryColor)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().warningColor)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ConstantColors().primaryColor)),
                          hintText: asProvider.getString("Enter password"),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 18)),
                    )),

                //Login button ==================>
                const SizedBox(
                  height: 13,
                ),

                CommonHelper().buttonOrange(asProvider.getString("Sign Up"),
                    () {
                  if (widget.passController.text !=
                      widget.repeatPassController.text) {
                    OthersHelper().showToast(
                        asProvider.getString("Password did not match"),
                        Colors.black);
                  } else if (widget.passController.text.length < 6) {
                    OthersHelper().showToast(
                        asProvider.getString(
                            "Password must be at least 6 characters"),
                        Colors.black);
                  } else if (_formKey.currentState!.validate()) {
                    // provider.pagecontroller.animateToPage(
                    //     provider.selectedPage + 1,
                    //     duration: const Duration(milliseconds: 300),
                    //     curve: Curves.ease);
                    provider.signup(
                        widget.fullNameController.text.trim(),
                        widget.emailController.text.trim(),
                        widget.userNameController.text.trim(),
                        widget.passController.text.trim(),
                        context);
                  }
                }),

                const SizedBox(
                  height: 25,
                ),
                SignupHelper().haveAccount(context),

                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
