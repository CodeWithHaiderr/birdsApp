import 'package:birdz_app/consts/firebase_consts.dart';
import 'package:birdz_app/controller/auth_controller.dart';
import 'package:birdz_app/dashboard.dart';
import 'package:birdz_app/main.dart';
import 'package:birdz_app/widgets/custom_textfield.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade400,
        body: SingleChildScrollView(
          child: Column(children: [
            const Padding(
                padding: EdgeInsets.only(top: 170),
                child: Text(
                  'Signup to Birds.pk',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                )),
            const SizedBox(height: 30,),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                  child: customTextField(hint: "Name",controller: nameController,isPass: false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                  child: customTextField(hint: "Email",controller: emailController,isPass: false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                  child: customTextField(hint: "Password",controller: passwordController,isPass: true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
                  child: customTextField(hint: "Retype Password",controller: repasswordController,isPass: true),
                ),
              ],
            ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                              isCheck = newValue;
                            },
                          ),
                          Expanded(
                            child: RichText(
                                text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                                TextSpan(
                                    text: "Terms and Condition",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoColors.white,
                                    )),
                                TextSpan(
                                    text: " & Privacy Policy",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoColors.white,
                                    )),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(()
                      => controller.isloading.value
                          ? loadingIndicator()
                          : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isCheck == true
                                ? Colors.green.shade700
                                : Colors.green.shade50,
                            padding: const EdgeInsets.only(left: 130, right: 130),
                          ),
                          onPressed: () async {
                            if(isCheck != false){
                              controller.isloading(true);
                              try{
                                await controller.signupMethod(context: context, email: emailController.text,password: passwordController.text)
                                    .then((value) {
                                   return controller.storeUserData(
                                     email: emailController.text,
                                     password: passwordController.text,
                                     name: nameController.text
                                   );
                                }).then((value) {
                                  VxToast.show(context, msg: "LogIn Successful");
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard()));
                                });
                              }
                              catch (e){
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already Have an account?',
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextSpan(
                            text: '  Log in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ).onTap(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }),
                  ],
                ),
        ),
    );

  }
}
