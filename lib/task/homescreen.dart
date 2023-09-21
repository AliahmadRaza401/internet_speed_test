import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:internet_speedtest_app/task/images.dart';
import 'package:internet_speedtest_app/task/slideablewidget.dart';

class HomeScreenTask extends StatefulWidget {
  const HomeScreenTask({super.key});

  @override
  State<HomeScreenTask> createState() => _HomeScreenTaskState();
}

class _HomeScreenTaskState extends State<HomeScreenTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: imageLiust.length,
        itemBuilder: (context, i) {
          return singleElement(
            context,
            imageLiust[i],
            'Red Komodo 6K',
            'Milano, Lombardia, Italia',
            '250€',
            'giorno',
            'Disponibile Adesso',
          );
        },
      ),
    );
  }
}
