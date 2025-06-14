import 'package:firebases/Model/coinModel.dart';
import 'package:firebases/View/Components/item.dart';
import 'package:firebases/View/Components/item2.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'Profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isRefreshing = true;
  List? coinMarket = [];
  var coinMarketList;

  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 253, 225, 112),
              Color(0xffFBC700),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section
              Padding(
                padding: EdgeInsets.symmetric(vertical: myHeight * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildTextContainer('Welcome To The Crypto  Market', myWidth, myHeight),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ 7,466.20',
                      style: TextStyle(fontSize: myHeight * 0.04),
                    ),

                    Container(
                      padding: EdgeInsets.all(myWidth * 0.0001),
                      margin: EdgeInsets.only(right: 15.0),
                      height: myHeight * 0.1, // Adjust size for better visibility
                      width: myWidth * 0.1,

                      child: GestureDetector(
                        onTap: () {
                          // Navigate to ChatbotScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ChatbotScreen()),
                          );
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Icon(
                            Icons.smart_toy, // Bot icon
                            key: UniqueKey(), // Helps with animation on change
                            size: 50.0, // Adjust size as needed
                            color: Colors.brown, // Adjust color
                          ),
                        ),
                      ),
                    )
                    ,
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.07),
                child: Text(
                  '+162% all time',
                  style: TextStyle(fontSize: myHeight * 0.02),
                ),
              ),
              SizedBox(height: myHeight * 0.02),

              // Middle Section
              Container(
                width: myWidth,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey.shade300,
                      spreadRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: myWidth * 0.07,
                    vertical: myHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSectionHeader('Our Top Assets', Icons.currency_bitcoin, myHeight),
                      SizedBox(height: myHeight * 0.02),
                      buildAssetsList(myHeight, myWidth),
                      SizedBox(height: myHeight * 0.02),
                      buildRecommendSection(myHeight, myWidth),
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

  Widget buildTextContainer(String text, double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.005,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: height * 0.02),
      ),
    );
  }

  Widget buildText(String text, double height) {
    return Text(
      text,
      style: TextStyle(fontSize: height * 0.02),
    );
  }

  Widget buildSectionHeader(String title, IconData icon, double height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: height * 0.025),
        ),
        Icon(icon),
      ],
    );
  }

  Widget buildAssetsList(double height, double width) {
    return Container(
      height: height * 0.36,
      child: isRefreshing
          ? Center(
        child: CircularProgressIndicator(color: const Color(0xffFBC700)),
      )
          : (coinMarket == null || coinMarket!.isEmpty)
          ? Center(
        child: Padding(
          padding: EdgeInsets.all(height * 0.06),
          child: Text(
            'Free API: Please wait before sending multiple requests.',
            style: TextStyle(fontSize: height * 0.018),
          ),
        ),
      )
          : ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Item(item: coinMarket![index]);
        },
      ),
    );
  }

  Widget buildRecommendSection(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommend to Buy',
          style: TextStyle(fontSize: height * 0.025, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: height * 0.01),
        SizedBox(
          height: height * 0.2,
          child: isRefreshing
              ? Center(
            child: CircularProgressIndicator(color: const Color(0xffFBC700)),
          )
              : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: coinMarket!.length,
            itemBuilder: (context, index) {
              return Item2(item: coinMarket![index]);
            },
          ),
        ),
      ],
    );
  }

  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });

    final response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefreshing = false;
    });

    if (response.statusCode == 200) {
      coinMarketList = coinModelFromJson(response.body);
      setState(() {
        coinMarket = coinMarketList;
      });
    }
    return coinMarketList;
  }
}
