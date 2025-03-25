import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/view/sections/favourites_section.dart';
import 'package:shopping_cart/view/sections/home_section.dart';
import 'package:shopping_cart/view/sections/profile_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username, required this.email});

  final String username;
  final String email;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hello, ${widget.username}'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          const HomeSection(),
          const FavouritesSection(),
          ProfileSection(username: widget.username,email: widget.email,),
        ],
        onPageChanged: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: const Color(0xFFFDF0D5),
        buttonBackgroundColor: Colors.transparent,
        color: Colors.black38,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.person, size: 30), // Updated icon
        ],
        index: _index,
        height: 55,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
        },
      ),
    );
  }
}