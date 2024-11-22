import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultTabController(
                length: 5,
                child: TabBar(
                  tabs: List.generate(
                    5,
                    (index) => Container(
                      height: 50,
                      width: 50,
                      color: Colors.yellow,
                    ),
                  ),
                )),

            headding_Section(),
            topsontainer_section(), // Fixed top section
            second_containersection(),
          ],
        ),
      ),
    );
  }

  Container headding_Section() {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.blue,
    );
  }

  Widget second_containersection() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          20, // Adjust the number of items as needed
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.green,
              title: Text(
                'Name $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container topsontainer_section() {
    return Container(
      height: 350, // Adjust height based on your needs
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                width: 200,
              ),
              Positioned(
                top: 200,
                left: 25,
                right: 25,
                child: Container(
                  color: Colors.white,
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
