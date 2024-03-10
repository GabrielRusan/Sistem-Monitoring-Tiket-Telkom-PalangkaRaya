import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telkom_ticket_manager/constants/style.dart';
import 'package:telkom_ticket_manager/routing/routes.dart';
import 'package:telkom_ticket_manager/widgets/custom_text.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset(
                      "assets/icons/logo_telkom.png",
                      height: 50,
                      width: 100,
                    ),
                  ),
                  Expanded(child: Container())
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(children: [
                Text(
                  "Login",
                  style: GoogleFonts.roboto(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ]),
              Row(
                children: [
                  CustomText(
                    text: "Selamat datang di panel admin!",
                    color: lightGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "admin",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.offAllNamed(rootRoute);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: active,
                  ),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
