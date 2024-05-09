import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_examfinal_gsa/screens/screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  List<Widget> _pages = [
    ListProveedoresScreen(),
    ListCategoryScreen(),
    ListProductScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          unselectedItemColor: Colors.black,
          selectedItemColor: Color.fromRGBO(212, 141, 9, 1),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Proveedores',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: 'Categorias',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.equal_square),
              label: 'Productos',
            ),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
