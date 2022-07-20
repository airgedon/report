import 'package:flutter/material.dart';

class CountButton extends StatelessWidget {
  const CountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 110,
      child: Row(
        children: [
          IconButton(
              splashRadius: 20,
              color: Colors.grey,
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.remove_circle)),
          const Text(
            '1',
            style: TextStyle(fontSize: 19),
          ),
          IconButton(
              color: Colors.grey,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.add_circle)),
        ],
      ),
    );
  }
}
