import 'package:flutter/material.dart';
import 'package:full_version_newsapp/controller/homeScreen_controller.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomescreenController>().gettopHeadline();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await context.read<HomescreenController>().gettopHeadline();
          },
          child: Text("test"),
        ),
        appBar: AppBar(
          title: Text("home screen"),
        ),
        body: Consumer<HomescreenController>(
          builder: (context, homeproviderobj, child) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 300,
                  child: ListView.separated(
                      itemBuilder: (context, index) => Card(
                            margin: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 5.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Stack(
                                children: [
                                  // Background image from network
                                  Positioned.fill(
                                    child: Image.network(
                                      homeproviderobj
                                          .topheadlines[index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Title container at the bottom
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 15.0),
                                      color: Colors.black.withOpacity(0.6),
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 25,
                          ),
                      itemCount: homeproviderobj.topheadlines.length),
                )
              ],
            ),
          ),
        ));
  }
}
