import 'package:flutter/material.dart';
import '../../../../component/appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: SafeArea(child: Column(children: [Text("Home screen")])),
    );
  }
}

