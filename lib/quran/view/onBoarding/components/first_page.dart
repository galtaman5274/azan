import 'package:flutter/material.dart';

import 'boarding_page.dart';
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BoardingPage(
        text: 'Let\'s vibe togather!Create your\nown playlist and enjoy music',
        title: 'Customize Your Beast');
  }
}
