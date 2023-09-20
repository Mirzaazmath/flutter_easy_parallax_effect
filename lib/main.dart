import 'package:flutter/material.dart';
/// MAIN
void main(){
  /// RUN APP
  runApp(MyApp());
}
/// MY APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// MATERIAL APP
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /// HOMESCREEN
      home: HomeScreen(),
    );
  }
}
/// HOME SCREEN
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /// PAGEVIEW CONTROLLER
  /// viewportFraction IS THE SIZE FOR PER PAGE
  PageController pageController=PageController(viewportFraction: 0.6);
  /// CREATE AN OFFSET TO HANDLE THE PARALLAX EFFECT
  double pageOffSet=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// PAGECONTROLLER addListener
    pageController.addListener(() {
      /// WHEN EVER THE CHANGES HAPPEN IT TRIGGER SET START WHICH CHANGE THE OFFSET VALUE
      /// OFFSET VALUE IS REALLY NEEDED TO PERFORM PARALLAX EFFECT
      setState(() {
        pageOffSet=pageController.page!;

      });
      /// PRINTING THE  CHANGES
      debugPrint(pageOffSet.toString());
    });
  }

  /// MAKE SURE TO DISPOSE THE CONTROLLER TO PREVENT MEMORY LEAK
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// SCAFFOLD
    return Scaffold(
/// APP BAR
      appBar: AppBar(title:const  Text("flutter  Parallax Effect"),
        elevation: 0,
      ),
      /// BODY
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(
            height: 300,
         /// HERE WE ARE USING THE PAGEVIEW BUILDER FOR OUR EFFECT
            child: PageView.builder(
              /// CONTROLLER
                controller:pageController,
                /// COUNT
                itemCount: itemList.length,

                itemBuilder: (context,index){
                  /// PRINTING THE VALUE
                debugPrint("${-pageOffSet.abs()+index}");
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                        child:SizedBox(
                          height: 300,
                          /// TWO THINGS TO UNDER WHILE USING CREATING THE PARALLAX EFFECT
                          /// 1. MAKE SURE TO ADD Alignment AND PASS THE OFFSET VALUE
                          /// 2. MAKE SURE TO USE BoxFit.cover, ONLY
                          child:  Image.asset(itemList[index].image,fit: BoxFit.cover,
                            alignment: Alignment(-pageOffSet.abs()+index,0),
                          ),
                        )
                      ),

                      /// POSITION FOR TEXT
                      Positioned(
                      bottom:20,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(itemList[index].name,
                        style:const  TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),

                      ),
                          ))
                    ],

              ),
                );
            }),
          )
        ],
      ),

    );
  }
}
class Item{
 final  String image;
 final String name;
 Item({required this.image,required this.name});
}

List<Item>itemList=[
  Item(image: "assets/place1.webp", name: "City"),
  Item(image: "assets/place2.jpeg", name: "Nature"),
  Item(image: "assets/place3.jpeg", name: "Mountain"),
  Item(image: "assets/place4.jpeg", name: "Beach"),
];