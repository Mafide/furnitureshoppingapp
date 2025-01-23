import 'package:flutter/material.dart';
import 'package:furnituree/ReviewPage.dart';
import 'package:furnituree/create_account_page.dart';
import 'AddToCartPage.dart';
import 'SettingsPage.dart';
import 'aboupage.dart';
import 'custom_bottom_navbar.dart';
import 'notificationpage.dart';
import 'product_details.dart';
import 'profilepage.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
import 'showcasepage.dart';
import 'user_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "Chair";
  String searchQuery = "";

  final Map<String, List<Map<String, String>>> furnitureItemsByCategory = {
    "Chair": [
      {
        'name': 'Bruges Accent Chair',
        'image': 'bruges.jpg',
        'description': 'Stylish and modern accent chair.',
        'price': '2500.0',
      },
      {
        'name': 'Mathis Stationary',
        'image': 'mathis.jpg',
        'description': 'Comfortable stationary chair.',
        'price': '1600.0',
      },
      {
        'name': 'Accent Chairs',
        'image': 'accent.jpg',
        'description': 'Elegant lounge chair for relaxing.',
        'price': '3600.0',
      },
      {
        'name': 'Gloria Lounge Chairs',
        'image': 'gloria-lounge.jpg',
        'description': 'Elegant lounge chair for relaxing.',
        'price': '4000.0',
      },
      {
        'name': 'UL Assured Picks',
        'image': 'UL_Assured_Picks.jpg',
        'description': 'Elegant lounge chair for relaxing.',
        'price': '2500.0',
      },
      {
        'name': 'Ottomans & Stools',
        'image': 'Ottoman.webp',
        'description': 'Elegant lounge chair for relaxing.',
        'price': '1600.0',
      },
      {
        'name': 'Gaming Chairs',
        'image': 'gaming.webp',
        'description': 'Comfortable and stylish gaming chair.',
        'price': '3000.0',
      },
      {
        'name': 'Bar stoools',
        'image': 'bar.webp',
        'description': 'Chic bar stools for home decor.',
        'price': '3000.0',
      },
      {
        'name': 'GuestChair Seating',
        'image': 'GuestChair_Seating.jpg',
        'description': 'Chic bar stools for home decor.',
        'price': '3000.0',
      },
      {
        'name': 'Eula Modern Accent chair',
        'image': 'eula.jpg',
        'description': 'Chic bar stools for home decor.',
        'price': '3000.0',
      },
    ],
    "Table": [
      {
        'name': 'Dining Table',
        'image': 'diningtable.webp',
        'description': 'Elegant wooden dining table.',
        'price': '4000.0',
      },
      {
        'name': 'Coffee Table',
        'image': 'coffetable.jpg',
        'description': 'Stylish glass-top coffee table.',
        'price': '2000.0',
      },
      {
        'name': 'Rustic Round Dining Table',
        'image': 'rustic.jpg',
        'description': 'Rustic charm for your dining area.',
        'price': '4000.0',
      },
      {
        'name': 'Hauge Dining Table',
        'image': 'round.jpg',
        'description': 'Elegant round dining table.',
        'price': '4000.0',
      },
      {
        'name': 'Mater Bowl Table',
        'image': 'mater.jpg',
        'description': 'Elegant round Bowl table.',
        'price': '4000.0',
      },
      {
        'name': 'Board Gaming Table',
        'image': 'board.jpg',
        'description': 'Elegant round dining table.',
        'price': '4000.0',
      },
      {
        'name': 'Hauge Dining Table',
        'image': 'round.jpg',
        'description': 'Elegant round dining table.',
        'price': '4000.0',
      },
      {
        'name': 'Coffee Table',
        'image': 'coffetable.jpg',
        'description': 'Stylish glass-top coffee table.',
        'price': '2000.0',
      },
    ],
    "Cupboard": [
      {
        'name': 'Wardrobe',
        'image': 'wardrobe.jpg',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
      {
        'name': 'White Wooden Wardrobe',
        'image': 'white.jpg',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
      {
        'name': 'Grey Wardrobe',
        'image': 'grey.jpg',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
      {
        'name': 'Cupboard Shelves',
        'image': 'cupboard.jpg',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
      {
        'name': 'UniqueWardrobe',
        'image': 'unique.jpg',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
      {
        'name': 'Ebco Cupboard Pullout',
        'image': 'ebco-cupboard-pullout.webp',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
      {
        'name': 'Great Wardrobe',
        'image': 'wardrobe.jpg',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
      {
        'name': 'Grey Wardrobe',
        'image': 'grey.jpg',
        'description': 'Spacious wooden wardrobe.',
        'price': '5000.0',
      },
    ],
    "Sofa": [
      {
        'name': 'Timber Grey Sofa',
        'image': 'timber.jpg',
        'description': 'Comfortable and stylish lounge sofa.',
        'price': '8000.0',
      },
      {
        'name': 'Trending sofa Design',
        'image': 'trending-sofa-designs-for-your-home.jpg',
        'description': 'Comfortable and stylish lounge sofa.',
        'price': '8000.0',
      },
      {
        'name': 'Lounge Sofa',
        'image': 'sofa.webp',
        'description': 'Comfortable and stylish lounge sofa.',
        'price': '8000.0',
      },
      {
        'name': 'Cososmo Sofa',
        'image': 'cosomo.jpg',
        'description': 'Comfortable and stylish lounge sofa.',
        'price': '8000.0',
      },
      {
        'name': 'Corner Sofa',
        'image': 'corner.jpg',
        'description': 'Comfortable and stylish lounge sofa.',
        'price': '8000.0',
      },
      {
        'name': 'Velvet Sofa',
        'image': 'velvet.jpg',
        'description': 'Comfortable and stylish lounge sofa.',
        'price': '8000.0',
      },
    ],
    "Bed": [
      {
        'name': 'Queen Size Bed',
        'image': 'bed.jpeg',
        'description': 'Luxurious queen-size bed with headboard.',
        'price': '12000.0',
      },
      {
        'name': 'Luxuary Modern Bed',
        'image': 'lux.jpg',
        'description': 'Luxurious queen-size bed with headboard.',
        'price': '12000.0',
      },
      {
        'name': 'Container Bed With Soft Headboard',
        'image': 'storage.jpg',
        'description': 'Luxurious queen-size bed with headboard.',
        'price': '12000.0',
      },
      {
        'name': 'The Stella Bed',
        'image': 'stella.jpg',
        'description': 'Luxurious queen-size bed with headboard.',
        'price': '12000.0',
      },
      {
        'name': 'Luxuary Modern Bed',
        'image': 'lux.jpg',
        'description': 'Luxurious queen-size bed with headboard.',
        'price': '12000.0',
      },
      {
        'name': 'Container Bed With Soft Headboard',
        'image': 'storage.jpg',
        'description': 'Luxurious queen-size bed with headboard.',
        'price': '12000.0',
      },
    ],
  };

  List<Map<String, String>> getFilteredItems() {
    final items = furnitureItemsByCategory[selectedCategory] ?? [];
    if (searchQuery.isEmpty) {
      return items;
    }
    return items
        .where((item) =>
            item['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final username = userProvider.username;
    final email = userProvider.email;
    final furnitureItems = furnitureItemsByCategory[selectedCategory] ?? [];
    final themeProvider = Provider.of<ThemeProvider>(context);
    final filteredItems = getFilteredItems();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xFFD3D3D3), 
        elevation: 0, 
        title: Text(
          "Furnitures",
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black, 
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.black, 
            ),
            onPressed: () {
              themeProvider.toggleTheme(
                themeProvider.isDarkMode ? false : true, 
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ),
          SizedBox(width: 16), 
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFD3D3D3),
              ),
              accountName: Text(
                username,
                style: TextStyle(
                    color: Colors.black), 
              ),
              accountEmail: Text(
                email,
                style: TextStyle(
                    color: Colors.black), 
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Cart'),
              onTap: () {
                Map<String, String> product = {};
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToCartPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Reviews'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewPage(product: {}),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('About App'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              
              Text(
                "Hi ${userProvider.username}, stylish furniture awaits!",
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 20), 
              // Search box
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search by name...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),

              
              SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowcasePage(),
                            ),
                          );
                        },
                        child: Image.asset('assets/showroom1.jpg',
                            width: 300, height: 300, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowcasePage(),
                            ),
                          );
                        },
                        child: Image.asset('assets/modernbedrooom.webp',
                            width: 300, height: 300, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowcasePage(),
                            ),
                          );
                        },
                        child: Image.asset('assets/stylish.jpeg',
                            width: 300, height: 300, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowcasePage(),
                            ),
                          );
                        },
                        child: Image.asset('assets/cozy.webp',
                            width: 300, height: 300, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowcasePage(),
                            ),
                          );
                        },
                        child: Image.asset('assets/luxury.jpg',
                            width: 300, height: 300, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final category in furnitureItemsByCategory.keys)
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Top $selectedCategory",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredItems.length,
               
                itemBuilder: (context, index) {
                 
                  final item = filteredItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            name: item['name'] ??
                                'Default Name', 
                            image: item['image'] ??
                                'default_image.png', 
                            description: item['description'] ??
                                'No description available', 
                            price: item['price']?.toString() ?? '0.0',
                            product: {}, 
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: Image.asset(
                                'assets/${item['image']}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "\EtB ${item['price']}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item['description']!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(context: context),
    );
  }
}
