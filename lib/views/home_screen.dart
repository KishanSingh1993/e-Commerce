import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ui_provider.dart';
import '../widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchDataFuture;
  late PageController _pageController; // Page controller for carousel
  int _currentPage = 0; // Current page index for the carousel

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = Provider.of<UIProvider>(context, listen: false).fetchData();
    _pageController = PageController(); // Initialize the PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = uiProvider.products ?? [];
          final banners = uiProvider.banners ?? [];
          final offers = uiProvider.offers ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header Banner with Carousel
                SizedBox(
                  height: 230,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: products.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8), // Space around each image
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2), // Shadow direction
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15), // Same border radius
                              child: Image.network(
                                products[index].thumbnail, // Image URL from API
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,top:0,right:10,bottom: 0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                products.length,
                                    (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  width: _currentPage == index ? 12 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _currentPage == index
                                        ? Colors.red
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            const SizedBox(height: 10),
                // 2. Buy Furniture Section
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Buy Items", style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return SizedBox(
                      height: 100,
                      child: Card(
                          child: Center(
                              child: Column(
                                children: [
                                  Image.network(product.thumbnail, height: 60, fit: BoxFit.cover),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.title, overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              ),
                          )
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // 3. Best Deals Section
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Best Deals", style: Theme.of(context).textTheme.headlineSmall),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return SizedBox(
                        width: 180,
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Image.network(product.thumbnail, height: 100, fit: BoxFit.cover),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(product.title, overflow: TextOverflow.ellipsis),
                              )
                              //Text("₹${product.price}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                // 4. Offers Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Offers & Discounts", style: Theme.of(context).textTheme.headlineMedium),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("View All"),
                    ),
                  ],
                ),
            SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: offers.length,
                    itemBuilder: (context, index) {
                      final offer = offers[index];
                      return Card(
                          color: Colors.yellowAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(offer.title, style: Theme.of(context).textTheme.displayMedium),
                              Text(offer.subtitle, style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Deals of the day", style: Theme.of(context).textTheme.headlineMedium),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("View All"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return SizedBox(
                        width: 250,
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Image.network(product.thumbnail, height: 200, fit: BoxFit.cover),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(product.title, overflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(height: 10),
                          SizedBox(
                            width: 250,
                            height: 45,
                            child: Card(
                              color: Colors.yellowAccent,
                              child: Center(
                                  child: Text("${product.discountPercentage}% ₹${product.price}",style: Theme.of(context).textTheme.headlineMedium)
                              ),
                            ),
                          ),

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/ui_provider.dart';
// import '../widgets/custom_appbar.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late Future<void> _fetchDataFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchDataFuture = Provider.of<UIProvider>(context, listen: false).fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final uiProvider = Provider.of<UIProvider>(context);
//
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: FutureBuilder(
//         future: _fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           final products = uiProvider.products ?? [];
//           final banners = uiProvider.banners ?? [];
//           final offers = uiProvider.offers ?? [];
//
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 1. Header Banner with Carousel
//                 SizedBox(
//                   height: 200,
//                   child: PageView.builder(
//                     itemCount: banners.length,
//                     itemBuilder: (context, index) {
//                       return Image.network(
//                         banners[index].imageUrl,
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   ),
//                 ),
//                 // 2. Buy Furniture Section
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("BUY FURNITURE", style: Theme.of(context).textTheme.headlineSmall),
//                   ),
//                 ),
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                   ),
//                   itemCount: 8,
//                   itemBuilder: (context, index) {
//                     return Card(child: Center(child: Text("Item $index")));
//                   },
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text("View All"),
//                 ),
//                 // 3. Best Deals Section
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text("BEST DEALS", style: Theme.of(context).textTheme.headlineSmall),
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: 150,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return SizedBox(
//                         width: 250,
//                         child: Card(
//                           child: Column(
//                             children: [
//                               Image.network(product.thumbnail, height: 100, fit: BoxFit.cover),
//                               Text(product.title, overflow: TextOverflow.ellipsis),
//                               Text("₹${product.price}"),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 // 4. Offers Section
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("OFFERS", style: Theme.of(context).textTheme.headlineSmall),
//                 ),
//                 SizedBox(
//                   height: 100,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: offers.length,
//                     itemBuilder: (context, index) {
//                       final offer = offers[index];
//                       return Card(
//                           color: Colors.yellowAccent,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(offer.title, style: Theme.of(context).textTheme.displayMedium),
//                               Text(offer.subtitle, style: Theme.of(context).textTheme.bodySmall),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
















// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/ui_provider.dart';
// import '../widgets/custom_widgets.dart';
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final uiProvider = Provider.of<UIProvider>(context);
//
//     if (uiProvider.uiConfig == null) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }
//
//     final config = uiProvider.uiConfig!;
//     return Scaffold(
//       appBar: AppBar(title: const Text("Dynamic UI Demo")),
//       body: ListView(
//         children: [
//           HeaderWidget(
//             title: config.header.title,
//             imageUrl: config.header.imageUrl,
//             discount: config.header.discount,
//           ),
//           const SizedBox(height: 20),
//           const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           GridView.count(
//             crossAxisCount: 3,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             children: config.categories
//                 .map((category) => Column(
//               children: [
//                 Image.network(category.icon, height: 50),
//                 Text(category.name),
//               ],
//             ))
//                 .toList(),
//           ),
//           const SizedBox(height: 20),
//           const Text("Offers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...config.offers.map((offer) => ListTile(
//             title: Text(offer.title),
//             subtitle: Text(offer.details),
//           )),
//           const SizedBox(height: 20),
//           const Text("Deals of the Day", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ...config.deals.map((deal) => Card(
//             child: Column(
//               children: [
//                 Image.network(deal.imageUrl),
//                 Text(deal.title),
//                 Text("Price: ${deal.price}"),
//                 Text("Discount: ${deal.discount}"),
//               ],
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }
