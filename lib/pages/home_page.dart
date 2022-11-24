import 'package:flutter/material.dart';
import 'package:sqlflutter/db/db_admin.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              DBAdmin.db.initDatabase();
            },
            child: const Text("Mostrar Informacion"),
          ),
        ],
      ),
      ),
    );
  }
}
