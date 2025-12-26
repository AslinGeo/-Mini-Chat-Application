import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_chat/app/core/index.dart';
import 'package:mini_chat/app/viewModels/index.dart';
import 'package:mini_chat/app/views/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String whichView = AppStrings.usersList;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20),
            toggleSection(),
            SizedBox(height: 20),
            Expanded(child: users()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.lightBlue,
          onPressed: () {
            showAddUserDialog(context);
          },
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

  Widget users() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return CircularProgressIndicator();
        } else if (state is HomeError) {
          return Text(state.message);
        } else if (state is HomeLoaded) {
          return state.users.isEmpty
              ? Center(child: Text(AppStrings.userEmptyMessage))
              : ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return UserWidget(user: state.users[index]);
                  },
                );
        }
        return Container();
      },
    );
  }

  Future<void> showAddUserDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(AppStrings.addUser),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 12),

                labelText: AppStrings.name,
                hintText: AppStrings.nameHintText,

                // Normal border
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),

                // Focused border
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),

                // Error border
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 1.5),
                ),

                // Focused error border
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 20,
              children: [
                CommonButton(
                  backgroundColor: Colors.transparent,
                  textColor: AppColors.black,
                  text: AppStrings.cancel,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                CommonButton(
                  width: 80,
                  backgroundColor: AppColors.lightBlue,
                  text: AppStrings.add,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<HomeBloc>().add(AddUser(controller.text));
                      Navigator.pop(context);
                      context.read<HomeBloc>().add(GetUsers());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppStrings.snackMessage.replaceAll(
                              "##user##",
                              controller.text,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
