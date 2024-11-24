import 'package:flutter/material.dart';
import 'package:full_version_newsapp/controller/catagodyscreen_controller.dart';
import 'package:full_version_newsapp/view/content_Screen/content_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Catagoryscreen extends StatefulWidget {
  const Catagoryscreen({super.key});

  @override
  State<Catagoryscreen> createState() => _CatagoryscreenState();
}

class _CatagoryscreenState extends State<Catagoryscreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<CatagoryscreenController>().gettopHeadline();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CatagoryscreenController>(
        builder: (context, providerogj, child) => providerogj.isloading
            ? Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: CatagoryscreenController.categoryList.length,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("catagory screen"),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        tabbar_section(providerogj),
                        body_section(providerogj),
                      ],
                    ),
                  ),
                ),
              ));
  }

  Column body_section(CatagoryscreenController providerogj) {
    return Column(
      children: List.generate(
        providerogj.topheadlines.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContentScreen(
                      title: providerogj.topheadlines[index].title.toString(),
                      content:
                          providerogj.topheadlines[index].content.toString(),
                      imageUrl:
                          providerogj.topheadlines[index].urlToImage.toString(),
                    ),
                  ));
            },
            child: Container(
              color: Colors.red,
              height: 200,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          providerogj.topheadlines[index].urlToImage.toString(),
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        providerogj.topheadlines[index].title.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            providerogj.topheadlines[index].source!.name
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            providerogj.topheadlines[index].publishedAt != null
                                ? DateFormat('yyyy-MM-dd hh:mm a').format(
                                    DateTime.parse(providerogj
                                        .topheadlines[index].publishedAt
                                        .toString()),
                                  )
                                : 'Unknown Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TabBar tabbar_section(CatagoryscreenController providerogj) {
    return TabBar(
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        tabs: List.generate(
          CatagoryscreenController.categoryList.length,
          (index) => Expanded(
            child: InkWell(
              onTap: () async {
                CatagoryscreenController.oncatagodyselection(index);
                await providerogj.gettopHeadline();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    CatagoryscreenController.categoryList[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
