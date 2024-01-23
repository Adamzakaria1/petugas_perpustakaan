import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: controller.formkey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.usernameController,
                decoration: InputDecoration(hintText: "Masukan Username"),
                validator: (value){
                  if (value!.length <5) {
                    return "username tidak boleh kosong";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.passwordController,
                decoration: InputDecoration(hintText: "Masukan Password"),
                validator: (value){
                  if (value!.length >8) {
                    return "password tidak boleh kosong";
                  }
                  return null;
                },
              ),
              Obx(() => controller.loading.value?
              CircularProgressIndicator():
                  ElevatedButton(onPressed: (){
                    controller.login();
                  }, child: Text("Login"))
              )
            ],
          ),
        ),
      ),
    );
  }
}
