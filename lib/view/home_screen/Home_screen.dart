import 'package:flutter/material.dart';
import 'package:full_version_newsapp/controller/homeScreen_controller.dart';
import 'package:full_version_newsapp/view/catagory_screen/catagoryscreen.dart';
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
          builder: (context, providerobj, child) => SingleChildScrollView(
            child: Column(
              children: [
                headding_Section(providerobj),
                topsontainer_section(providerobj),
                tabbar_section(providerobj),
                second_containersection(providerobj),
              ],
            ),
          ),
        ));
  }

  DefaultTabController tabbar_section(HomescreenController providerobj) {
    return DefaultTabController(
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
        ));
  }

  Container headding_Section(HomescreenController providerobj) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.blue,
    );
  }

  Widget second_containersection(HomescreenController providerobj) {
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
              Container(
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
                      // Row(
                      //   children: [
                      //     Text(
                      //       providerobj.topheadlines[index].source!.name
                      //           .toString(),
                      //     )
                      //   ],
                      // ),
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
