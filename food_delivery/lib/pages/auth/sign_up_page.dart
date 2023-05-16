import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key?key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = [
      "t.jpg",
      "f.jpg",
      "g.jpg"
    ];

    void _registration(AuthController authController){
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Type in your name", title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in email address", title: "Email address");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }else{
        //showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
          name: name, 
          phone: phone, 
          email: email, 
          password: password);
          authController.registration(signUpBody).then((status){
            if(status.isSuccess){
              Get.offNamed(RouteHelper.getInitial());
            }else{
              showCustomSnackBar(status.message);
            }
          }
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05,),
            Container(
              height: Dimensions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/image/logo.jpg"
                  ),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(Dimensions.radius30),
            //     boxShadow: [
            //       BoxShadow(
            //         blurRadius: 10,
            //         spreadRadius: 7,
            //         offset: Offset(1, 10),
            //         color: Colors.grey.withOpacity(0.2)
            //       )
            //     ]
            //   ),
            //   child: TextField(
            //     controller: emailController,
            //     decoration: InputDecoration(
            //       //hintText
            //       hintText: "Email",
            //       //prefixIcon
            //       prefixIcon: Icon(Icons.email, color: AppColors.yellowColor),
            //       //focusedBorder
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(Dimensions.radius30),
            //         borderSide: BorderSide(
            //           width: 1.0,
            //           color: Colors.white
            //         )
            //       ),
            //       //enableBorder
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(Dimensions.radius30),
            //         borderSide: BorderSide(
            //           width: 1.0,
            //           color: Colors.white
            //         )
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(Dimensions.radius30),        
            //       )
            //     ),
            //   ),
            // )
            AppTextField(textController: emailController, 
            hintText: "Email", 
            icon: Icons.email),
            SizedBox(height: Dimensions.height20,),

            AppTextField(textController: passwordController, 
            hintText: "Password", 
            icon: Icons.password_sharp, isObscure : true,),
            SizedBox(height: Dimensions.height20,),

            AppTextField(textController: nameController, 
            hintText: "Name", 
            icon: Icons.person),
            SizedBox(height: Dimensions.height20,),

            AppTextField(textController: phoneController, 
            hintText: "Phone", 
            icon: Icons.phone),
            SizedBox(height: Dimensions.height20,),

            GestureDetector(
              onTap: (){
                _registration(_authController);
              },
              child: Container(
                width: Dimensions.screenWidth/2,
                height: Dimensions.screenHeight/13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor
                ),
                child: Center(
                  child: BigText(
                    text: "Sigh Up",
                    size: Dimensions.font20 + Dimensions.font20/2,
                    color: Colors.white,
                    ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10,),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                text: "Have an account already?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20
                )
              ),
            ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                text: "Sign up using one of the following methods",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16
                )
              )
            ),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: Dimensions.radius30,
                  backgroundImage: AssetImage(
                    "assets/image/"+signUpImage[index]
                  ),
                ),
                )),
              )
            ]
          ),
      ):const CustomLoader();
      })
    );
  }
}