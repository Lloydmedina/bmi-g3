// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:get/get.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              // Colors.white,
              // Colors.yellow,
              Colors.blue,
              Colors.green,
            ],
          )),
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              _tittle(),
              SizedBox(
                height: 100,
              ),
              _userinput(),
              SizedBox(
                height: 5,
              ),
              _passwordinput(),
              SizedBox(
                height: 5,
              ),
              _submitbtn()
            ],
          ),
        ),
      )),
    );
  }

  Widget _tittle() {
    return Text(
      "Wellness App",
      style: TextStyle(fontSize: 50),
    );
  }

  Widget _userinput() {
    return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
            decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 5, color: Colors.greenAccent)),
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.white),
        )));
  }

  Widget _passwordinput() {
    return Container(
        margin: EdgeInsets.all(20),
        child: TextField(
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white)));
  }

  Widget _submitbtn() {
    return Container(
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 84, 93, 223),
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          onPressed: () {
            Get.toNamed("/home");
          },
          child: const Text(
            'Log in',
            style: TextStyle(fontSize: 24),
          )),
    );
  }
}
