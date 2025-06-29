import 'package:flutter/material.dart';
import 'package:flutter_store_app/core/helper/logout_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    logout(context);
                  },
                  child: Text('data'))
            ],
          ),
        ),
      ),
    );
  }
}
