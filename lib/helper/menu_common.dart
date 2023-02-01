import 'package:flutter/material.dart';
import 'package:web_wot/screen/menu.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
    required double size,
  })  : _size = size,
        super(key: key);

  final double _size;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.easeIn,
      vsync: this,
      duration: const Duration(milliseconds: 500),
      child: LeftDrawer(
        size: widget._size,
      ),
    );
  }
}
