import 'package:flutter/material.dart';
import 'package:mini_chat/app/core/index.dart';
import 'package:mini_chat/app/views/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String whichView = AppStrings.usersList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [SizedBox(height: 20), toggleSection()]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.lightBlue,
          onPressed: () {},
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }

  Widget toggleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.lightGray,
        ),
        child: Row(
          children: [
            Expanded(
              child: CommonButton(
                height: 50,
                text: AppStrings.usersList,
                backgroundColor: whichView == AppStrings.usersList
                    ? AppColors.lightBlue
                    : AppColors.lightGray,
                textColor: whichView == AppStrings.usersList
                    ? AppColors.white
                    : AppColors.black,
                onPressed: () {
                  setState(() {
                    whichView = AppStrings.usersList;
                  });
                },
              ),
            ),
            Expanded(
              child: CommonButton(
                height: 50,
                text: AppStrings.chatHistory,
                backgroundColor: whichView == AppStrings.chatHistory
                    ? AppColors.lightBlue
                    : AppColors.lightGray,
                textColor: whichView == AppStrings.chatHistory
                    ? AppColors.white
                    : AppColors.black,
                onPressed: () {
                  setState(() {
                    whichView = AppStrings.chatHistory;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
