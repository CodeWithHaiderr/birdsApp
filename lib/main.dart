import 'package:birdz_app/signup.dart';
import 'package:birdz_app/consts/lists.dart';
import 'package:birdz_app/controller/auth_controller.dart';
import 'package:birdz_app/dashboard.dart';
import 'package:birdz_app/firebase_options.dart';
import 'package:birdz_app/splash_screen.dart';
import 'package:birdz_app/widgets/custom_textfield.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
        backgroundColor: Colors.green.shade400,
        body: Stack(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 170,left: 40),
                    child: Text('Login to Birds.pk',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.white,),)),
                Obx(() =>
                    SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.3,right: 35,left: 35),
                      child: Column(

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                            child: customTextField(hint: "Email",isPass: false,controller: controller.emailController),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
                            child: customTextField(hint: "Password",isPass: true,controller: controller.passwordController),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                         Align(
                           alignment: Alignment.centerRight,
                           child: TextButton(
                               onPressed: (){},
                               child: const Text('Forget Password',style: TextStyle(color: Colors.white),),),
                         ),
                          controller.isloading.value
                              ?  loadingIndicator()
                              : SizedBox(
                            width: context.screenWidth - 100,
                                child: ElevatedButton(
                                onPressed: () async {
                                  controller.isloading(true);
                                  await controller.loginMethod(context: context).then((value){
                                    if(value!=null){
                                      VxToast.show(context, msg: "LogIn Successful");
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard()));
                                    }
                                    else{
                                      controller.isloading(false);
                                    }
                                  });
                                  }, child: const Text('Login',style: TextStyle(fontSize: 15,color: Colors.white,),)),
                              ),

                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              const Text("     Don't have account?",style: TextStyle(color: Colors.white),),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                              },
                                  child: const Text('SignUp.' ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          const Center(child: Text('or Login with', style: TextStyle(color: Colors.white),)),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(2, (index) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: Colors.greenAccent,
                                radius: 20,
                                child: Image.asset(socialIconList[index],
                                width: 25,
                                ),
                              ),
                            ))
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),

    );



  }
}

