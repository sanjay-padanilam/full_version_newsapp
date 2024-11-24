import 'package:flutter/material.dart';
import 'package:full_version_newsapp/controller/homeScreen_controller.dart';
import 'package:full_version_newsapp/view/catagory_screen/catagoryscreen.dart';
import 'package:full_version_newsapp/view/content_Screen/content_screen.dart';
import 'package:intl/intl.dart';
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
      (timeStamp) async {
        await context.read<HomescreenController>().gettopHeadline();
        await context.read<HomescreenController>().getarticle();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HomeScreen"),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Catagoryscreen(),
                    ));
              },
              icon: Icon(Icons.apps)),
        ),
        body: Consumer<HomescreenController>(
          builder: (context, providerobj, child) => providerobj.isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      topsontainer_section(providerobj),
                      second_containersection(providerobj),
                    ],
                  ),
                ),
        ));
  }

  Widget second_containersection(HomescreenController providerobj) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          providerobj
              .everythinglist.length, // Adjust the number of items as needed
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentScreen(
                          title: providerobj.everythinglist[index].title
                              .toString(),
                          content: providerobj.everythinglist[index].content
                              .toString(),
                          imageUrl: providerobj.everythinglist[index].urlToImage
                              .toString()),
                    ));
              },
              child: Container(
                color: Colors.red,
                height: 150,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            providerobj.everythinglist[index].urlToImage
                                .toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            providerobj.everythinglist[index].title.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  providerobj.everythinglist[index].source!.name
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                              Text(
                                providerobj.everythinglist[index].publishedAt !=
                                        null
                                    ? DateFormat('yyyy-MM-dd hh:mm a').format(
                                        DateTime.parse(providerobj
                                            .everythinglist[index].publishedAt
                                            .toString()),
                                      )
                                    : 'Unknown Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container topsontainer_section(HomescreenController providerobj) {
    return Container(
      height: 400, // Adjust height based on your needs
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: providerobj.topheadlines.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentScreen(
                            title: providerobj.topheadlines[index].title
                                .toString(),
                            content: providerobj.topheadlines[index].content
                                .toString(),
                            imageUrl: providerobj.topheadlines[index].urlToImage
                                .toString()),
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: 250,
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                        fit: BoxFit.fitHeight,
                        providerobj.topheadlines[index].urlToImage.toString()),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 25,
                right: 25,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 150,
                  width: 100,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            providerobj.topheadlines[index].title.toString()),
                      ),
                      Spacer(),
                      Text(
                        providerobj.topheadlines[index].source!.id.toString(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
