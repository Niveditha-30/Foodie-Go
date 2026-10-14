import 'package:flutter/material.dart';

void main() {
  runApp(const FoodieGoApp());
}

// ============================================================
// APP
// ============================================================

class FoodieGoApp extends StatefulWidget {
  const FoodieGoApp({super.key});

  @override
  State<FoodieGoApp> createState() => _FoodieGoAppState();
}

class _FoodieGoAppState extends State<FoodieGoApp> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodieGo',
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xfff8f8f8),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        brightness: Brightness.dark,
      ),

      home: MainScreen(
        darkMode: darkMode,
        onThemeChanged: (value) {
          setState(() {
            darkMode = value;
          });
        },
      ),
    );
  }
}

// ============================================================
// FOOD MODEL
// ============================================================

class Food {
  final String name;
  final String category;
  final double price;
  final String image;
  final double rating;
  final int deliveryMinutes;
  final List<String> moods;

  const Food({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.rating,
    required this.deliveryMinutes,
    required this.moods,
  });
}

// ============================================================
// FOOD DATA
// ============================================================

const List<Food> foods = [
  Food(
    name: "Chicken Biryani",
    category: "Biryani",
    price: 249,
    rating: 4.8,
    deliveryMinutes: 30,
    moods: ["Spicy", "Party", "Happy"],
    image:
        "https://images.unsplash.com/photo-1563379091339-03246963d96c",
  ),
  Food(
    name: "Cheese Burger",
    category: "Burger",
    price: 149,
    rating: 4.6,
    deliveryMinutes: 25,
    moods: ["Happy", "Lazy", "Party"],
    image:
        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd",
  ),
  Food(
    name: "Margherita Pizza",
    category: "Pizza",
    price: 299,
    rating: 4.7,
    deliveryMinutes: 35,
    moods: ["Happy", "Party", "Relaxed"],
    image:
        "https://images.unsplash.com/photo-1574071318508-1cdbab80d002",
  ),
  Food(
    name: "French Fries",
    category: "Snacks",
    price: 99,
    rating: 4.5,
    deliveryMinutes: 15,
    moods: ["Lazy", "Party", "Happy"],
    image:
        "https://images.unsplash.com/photo-1573080496219-bb080dd4f877",
  ),
  Food(
    name: "Chocolate Cake",
    category: "Dessert",
    price: 129,
    rating: 4.8,
    deliveryMinutes: 20,
    moods: ["Happy", "Relaxed", "Lazy"],
    image:
        "https://images.unsplash.com/photo-1578985545062-69928b1d9587",
  ),
  Food(
    name: "Noodles",
    category: "Chinese",
    price: 179,
    rating: 4.5,
    deliveryMinutes: 25,
    moods: ["Spicy", "Relaxed", "Happy"],
    image:
        "https://images.unsplash.com/photo-1569718212165-3a8278d5f624",
  ),
];

// ============================================================
// MAIN SCREEN
// ============================================================

class MainScreen extends StatefulWidget {
  final bool darkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainScreen({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Food> cart = [];
  final List<Food> favorites = [];

  // ==========================================================
  // ADD TO CART
  // ==========================================================

  void addToCart(Food food) {
    setState(() {
      cart.add(food);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${food.name} added to cart"),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: "VIEW",
          onPressed: () {
            setState(() {
              currentIndex = 4;
            });
          },
        ),
      ),
    );
  }

  // ==========================================================
  // FAVORITE
  // ==========================================================

  void toggleFavorite(Food food) {
    setState(() {
      if (favorites.contains(food)) {
        favorites.remove(food);
      } else {
        favorites.add(food);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        cart: cart,
        favorites: favorites,
        addToCart: addToCart,
        toggleFavorite: toggleFavorite,
        onMoodAI: () {
          setState(() {
            currentIndex = 2;
          });
        },
      ),

      SearchScreen(
        addToCart: addToCart,
        toggleFavorite: toggleFavorite,
        favorites: favorites,
      ),

      FoodMoodScreen(
        addToCart: addToCart,
        toggleFavorite: toggleFavorite,
        favorites: favorites,
      ),

      FavoriteScreen(
        favorites: favorites,
        addToCart: addToCart,
        toggleFavorite: toggleFavorite,
      ),

      CartScreen(
        cart: cart,
      ),

      ProfileScreen(
        darkMode: widget.darkMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Search",
          ),

          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: "Mood AI",
          ),

          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: "Favorites",
          ),

          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  final List<Food> cart;
  final List<Food> favorites;
  final ValueChanged<Food> addToCart;
  final ValueChanged<Food> toggleFavorite;
  final VoidCallback onMoodAI;

  const HomeScreen({
    super.key,
    required this.cart,
    required this.favorites,
    required this.addToCart,
    required this.toggleFavorite,
    required this.onMoodAI,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // HEADER
            Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.person),
                ),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Good Morning 👋",
                        style: TextStyle(fontSize: 13),
                      ),

                      Text(
                        "Niveditha",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content:
                            Text("No new notifications"),
                      ),
                    );
                  },

                  icon: const Icon(
                    Icons.notifications_none,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // LOCATION
            Container(
              padding: const EdgeInsets.all(13),

              decoration: BoxDecoration(
                color:
                    Colors.deepOrange.withValues(alpha: 0.10),

                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.deepOrange,
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      "Deliver to: Hyderabad",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // SEARCH
            TextField(
              readOnly: true,

              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Use the Search tab to find food",
                    ),
                  ),
                );
              },

              decoration: InputDecoration(
                hintText:
                    "Search food or restaurants...",

                prefixIcon:
                    const Icon(Icons.search),

                suffixIcon:
                    const Icon(Icons.tune),

                filled: true,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),

                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // FOOD MOOD AI
            // ==================================================

            GestureDetector(
              onTap: onMoodAI,

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20),

                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xffff512f),
                      Color(0xfff09819),
                    ],
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange
                          .withValues(alpha: 0.20),

                      blurRadius: 10,

                      offset:
                          const Offset(0, 5),
                    ),
                  ],
                ),

                child: Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,

                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withValues(alpha: 0.20),

                        shape: BoxShape.circle,
                      ),

                      child: const Center(
                        child: Text(
                          "🤖",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Food Mood AI ✨",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Tell us your mood. "
                            "We'll pick your food!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // OFFER
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20),

                gradient:
                    const LinearGradient(
                  colors: [
                    Colors.deepOrange,
                    Colors.orange,
                  ],
                ),
              ),

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    "50% OFF",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "On your first order",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Use code: FIRST50",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // CATEGORIES
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {},

                  child:
                      const Text("See All"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 100,

              child: ListView(
                scrollDirection:
                    Axis.horizontal,

                children: const [
                  Category(
                    icon: "🍕",
                    name: "Pizza",
                  ),

                  Category(
                    icon: "🍔",
                    name: "Burger",
                  ),

                  Category(
                    icon: "🍗",
                    name: "Biryani",
                  ),

                  Category(
                    icon: "🍜",
                    name: "Chinese",
                  ),

                  Category(
                    icon: "🍰",
                    name: "Dessert",
                  ),

                  Category(
                    icon: "🍟",
                    name: "Snacks",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // POPULAR FOOD
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  "Popular Food",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {},

                  child:
                      const Text("See All"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount: foods.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 280,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),

              itemBuilder: (context, index) {
                final food = foods[index];

                return FoodCard(
                  food: food,

                  isFavorite:
                      favorites.contains(food),

                  onFavorite: () {
                    toggleFavorite(food);
                  },

                  onAdd: () {
                    addToCart(food);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY
// ============================================================

class Category extends StatelessWidget {
  final String icon;
  final String name;

  const Category({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,

      margin:
          const EdgeInsets.only(right: 12),

      child: Column(
        children: [
          Container(
            height: 65,
            width: 65,

            decoration: BoxDecoration(
              color: Colors.orange
                  .withValues(alpha: 0.15),

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: Center(
              child: Text(
                icon,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            name,
            style: const TextStyle(
              fontWeight:
                  FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FOOD CARD
// ============================================================

class FoodCard extends StatelessWidget {
  final Food food;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onAdd;

  const FoodCard({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.onFavorite,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) {
              return FoodDetailsScreen(
                food: food,
                onAdd: onAdd,
              );
            },
          ),
        );
      },

      child: Card(
        elevation: 2,

        clipBehavior:
            Clip.antiAlias,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                Image.network(
                  food.image,

                  height: 135,
                  width: double.infinity,

                  fit: BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) {
                    return Container(
                      height: 135,

                      color:
                          Colors.orange.shade100,

                      child:
                          const Center(
                        child: Icon(
                          Icons.fastfood,
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),

                Positioned(
                  right: 8,
                  top: 8,

                  child: Container(
                    decoration:
                        const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: IconButton(
                      padding:
                          const EdgeInsets.all(7),

                      constraints:
                          const BoxConstraints(),

                      onPressed:
                          onFavorite,

                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,

                        color: isFavorite
                            ? Colors.red
                            : Colors.black,

                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding:
                  const EdgeInsets.fromLTRB(
                10,
                8,
                10,
                8,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    food.name,

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color:
                            Colors.orange,
                      ),

                      const SizedBox(width: 3),

                      Text(
                        food.rating
                            .toString(),
                        style:
                            const TextStyle(
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Text(
                        "• ${food.deliveryMinutes} min",
                        style:
                            const TextStyle(
                          fontSize: 12,
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      Text(
                        "₹${food.price.toInt()}",

                        style:
                            const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      InkWell(
                        onTap: onAdd,

                        child: Container(
                          height: 38,
                          width: 38,

                          decoration:
                              BoxDecoration(
                            color:
                                Colors.deepOrange,

                            borderRadius:
                                BorderRadius
                                    .circular(
                              10,
                            ),
                          ),

                          child:
                              const Icon(
                            Icons.add,
                            color:
                                Colors.white,
                            size: 23,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FOOD MOOD AI
// ============================================================

class FoodMoodScreen extends StatefulWidget {
  final ValueChanged<Food> addToCart;
  final ValueChanged<Food> toggleFavorite;
  final List<Food> favorites;

  const FoodMoodScreen({
    super.key,
    required this.addToCart,
    required this.toggleFavorite,
    required this.favorites,
  });

  @override
  State<FoodMoodScreen> createState() =>
      _FoodMoodScreenState();
}

class _FoodMoodScreenState
    extends State<FoodMoodScreen> {
  String selectedMood = "Happy";

  double selectedBudget = 250;

  int selectedTime = 30;

  final List<Map<String, dynamic>> moods = [
    {
      "name": "Happy",
      "emoji": "😊",
      "color": Colors.amber,
    },
    {
      "name": "Relaxed",
      "emoji": "😌",
      "color": Colors.blue,
    },
    {
      "name": "Spicy",
      "emoji": "🔥",
      "color": Colors.red,
    },
    {
      "name": "Party",
      "emoji": "🥳",
      "color": Colors.purple,
    },
    {
      "name": "Lazy",
      "emoji": "😴",
      "color": Colors.green,
    },
  ];

  // ==========================================================
  // RECOMMENDATIONS
  // ==========================================================

  List<Food> get recommendations {
    final filtered = foods.where((food) {
      return food.price <= selectedBudget &&
          food.deliveryMinutes <= selectedTime &&
          food.moods.contains(selectedMood);
    }).toList();

    filtered.sort(
      (a, b) {
        return recommendationScore(b)
            .compareTo(
          recommendationScore(a),
        );
      },
    );

    return filtered;
  }

  // ==========================================================
  // AI SCORE
  // ==========================================================

  double recommendationScore(Food food) {
    double score = 0;

    if (food.moods.contains(selectedMood)) {
      score += 50;
    }

    if (food.price <= selectedBudget) {
      score += 20;
    }

    if (food.deliveryMinutes <= selectedTime) {
      score += 20;
    }

    score += food.rating * 2;

    return score;
  }

  // ==========================================================
  // REASON
  // ==========================================================

  String recommendationReason(Food food) {
    final reasons = <String>[];

    if (food.moods.contains(selectedMood)) {
      reasons.add("$selectedMood mood");
    }

    if (food.price <= selectedBudget) {
      reasons.add("within budget");
    }

    if (food.deliveryMinutes <= selectedTime) {
      reasons.add(
        "${food.deliveryMinutes} min delivery",
      );
    }

    return reasons.join(" • ");
  }

  @override
  Widget build(BuildContext context) {
    final results = recommendations;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Food Mood AI 🤖"),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ==================================================
            // AI HEADER
            // ==================================================

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(22),

                gradient:
                    const LinearGradient(
                  colors: [
                    Colors.deepOrange,
                    Colors.orange,
                    Colors.amber,
                  ],
                ),
              ),

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    "✨ Food Mood AI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Don't know what to eat?\n"
                    "Tell us your mood and "
                    "we'll decide!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // MOOD
            // ==================================================

            const Text(
              "1. What's your mood?",
              style: TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 105,

              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal,

                itemCount:
                    moods.length,

                itemBuilder:
                    (context, index) {
                  final mood =
                      moods[index];

                  final isSelected =
                      selectedMood ==
                          mood["name"];

                  final Color
                      moodColor =
                      mood["color"]
                          as Color;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMood =
                            mood["name"];
                      });
                    },

                    child:
                        AnimatedContainer(
                      duration:
                          const Duration(
                        milliseconds: 250,
                      ),

                      width: 90,

                      margin:
                          const EdgeInsets
                              .only(
                        right: 12,
                      ),

                      decoration:
                          BoxDecoration(
                        color: isSelected
                            ? moodColor
                                .withValues(
                                alpha: 0.20,
                              )
                            : Theme.of(
                                context,
                              )
                                .colorScheme
                                .surfaceContainerHighest,

                        borderRadius:
                            BorderRadius
                                .circular(
                          18,
                        ),

                        border:
                            Border.all(
                          color: isSelected
                              ? moodColor
                              : Colors
                                  .transparent,

                          width: 2,
                        ),
                      ),

                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [
                          Text(
                            mood["emoji"],
                            style:
                                const TextStyle(
                              fontSize: 30,
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          Text(
                            mood["name"],
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // BUDGET
            // ==================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [
                const Text(
                  "2. Your budget",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                Text(
                  "₹${selectedBudget.toInt()}",
                  style:
                      const TextStyle(
                    color:
                        Colors.deepOrange,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),

            Slider(
              value: selectedBudget,

              min: 100,
              max: 500,

              divisions: 8,

              activeColor:
                  Colors.deepOrange,

              label:
                  "₹${selectedBudget.toInt()}",

              onChanged: (value) {
                setState(() {
                  selectedBudget =
                      value;
                });
              },
            ),

            const Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [
                Text("₹100"),
                Text("₹500"),
              ],
            ),

            const SizedBox(height: 20),

            // ==================================================
            // TIME
            // ==================================================

            const Text(
              "3. How quickly do you need it?",
              style: TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,

              children:
                  [15, 30, 45, 60]
                      .map(
                (time) {
                  final selected =
                      selectedTime ==
                          time;

                  return ChoiceChip(
                    label: Text(
                      "Under $time min",
                    ),

                    selected:
                        selected,

                    selectedColor:
                        Colors.deepOrange
                            .withValues(
                      alpha: 0.20,
                    ),

                    onSelected:
                        (_) {
                      setState(() {
                        selectedTime =
                            time;
                      });
                    },
                  );
                },
              ).toList(),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // RESULTS
            // ==================================================

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Your Food Mood Picks 🍴",
                    style:
                        TextStyle(
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),

                if (results
                    .isNotEmpty)
                  Text(
                    "${results.length} found",
                    style:
                        const TextStyle(
                      color:
                          Colors.grey,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            if (results.isEmpty)
              _noRecommendationState()
            else
              ...results.map(
                (food) {
                  return _recommendationCard(
                    context,
                    food,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // RECOMMENDATION CARD
  // ==========================================================

  Widget _recommendationCard(
    BuildContext context,
    Food food,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),

      elevation: 2,

      clipBehavior:
          Clip.antiAlias,

      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                food.image,

                height: 180,
                width: double.infinity,

                fit: BoxFit.cover,

                errorBuilder:
                    (context, error, stackTrace) {
                  return Container(
                    height: 180,

                    color:
                        Colors.orange.shade100,

                    child:
                        const Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 60,
                      ),
                    ),
                  );
                },
              ),

              Positioned(
                top: 12,
                left: 12,

                child: Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),

                  decoration:
                      BoxDecoration(
                    color:
                        Colors.deepOrange,

                    borderRadius:
                        BorderRadius
                            .circular(
                      20,
                    ),
                  ),

                  child: const Text(
                    "AI PICK ✨",
                    style:
                        TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 10,
                top: 10,

                child: CircleAvatar(
                  backgroundColor:
                      Colors.white,

                  child: IconButton(
                    padding:
                        EdgeInsets.zero,

                    onPressed: () {
                      widget.toggleFavorite(
                        food,
                      );
                    },

                    icon: Icon(
                      widget.favorites
                              .contains(
                            food,
                          )
                          ? Icons.favorite
                          : Icons
                              .favorite_border,

                      color: widget
                              .favorites
                              .contains(
                            food,
                          )
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding:
                const EdgeInsets.all(
              14,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        food.name,

                        style:
                            const TextStyle(
                          fontSize: 19,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      "⭐ ${food.rating}",
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 7,
                ),

                Text(
                  recommendationReason(
                    food,
                  ),

                  style: TextStyle(
                    color:
                        Colors.deepOrange
                            .shade700,

                    fontSize: 13,

                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Row(
                  children: [
                    Text(
                      "₹${food.price.toInt()}",

                      style:
                          const TextStyle(
                        fontSize: 19,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    const Icon(
                      Icons.access_time,
                      size: 17,
                      color:
                          Colors.grey,
                    ),

                    const SizedBox(
                      width: 4,
                    ),

                    Text(
                      "${food.deliveryMinutes} min",
                      style:
                          const TextStyle(
                        color:
                            Colors.grey,
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton.icon(
                      onPressed: () {
                        widget.addToCart(
                          food,
                        );
                      },

                      icon:
                          const Icon(
                        Icons
                            .add_shopping_cart,
                        size: 18,
                      ),

                      label:
                          const Text(
                        "Add",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // NO RESULT
  // ==========================================================

  Widget _noRecommendationState() {
    return Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(25),

      decoration:
          BoxDecoration(
        color: Colors.orange
            .withValues(
          alpha: 0.08,
        ),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child: const Column(
        children: [
          Text(
            "😅",
            style:
                TextStyle(
              fontSize: 50,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "No perfect match found",
            style:
                TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          SizedBox(height: 6),

          Text(
            "Try increasing your budget "
            "or delivery time.",
            textAlign:
                TextAlign.center,

            style:
                TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FOOD DETAILS
// ============================================================

class FoodDetailsScreen
    extends StatelessWidget {
  final Food food;
  final VoidCallback onAdd;

  const FoodDetailsScreen({
    super.key,
    required this.food,
    required this.onAdd,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Food Details"),
      ),

      body:
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Image.network(
              food.image,

              height: 280,
              width: double.infinity,

              fit: BoxFit.cover,

              errorBuilder:
                  (context, error, stackTrace) {
                return Container(
                  height: 280,

                  color:
                      Colors.orange.shade100,

                  child:
                      const Center(
                    child: Icon(
                      Icons.fastfood,
                      size: 80,
                    ),
                  ),
                );
              },
            ),

            Padding(
              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    food.name,

                    style:
                        const TextStyle(
                      fontSize: 27,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color:
                            Colors.orange,
                      ),

                      Text(
                        " ${food.rating}  •  "
                        "${food.deliveryMinutes} min",

                        style:
                            const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    "₹${food.price.toInt()}",

                    style:
                        const TextStyle(
                      fontSize: 25,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.deepOrange,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Text(
                    "Description",

                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Delicious ${food.name} "
                    "prepared with fresh "
                    "ingredients and authentic "
                    "flavors. Perfect for lunch "
                    "or dinner.",

                    style:
                        const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child:
                        ElevatedButton.icon(
                      onPressed: () {
                        onAdd();

                        Navigator.pop(
                          context,
                        );
                      },

                      icon:
                          const Icon(
                        Icons
                            .shopping_cart,
                      ),

                      label:
                          const Text(
                        "Add to Cart",
                        style:
                            TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SEARCH SCREEN
// ============================================================

class SearchScreen
    extends StatefulWidget {
  final ValueChanged<Food> addToCart;
  final ValueChanged<Food> toggleFavorite;
  final List<Food> favorites;

  const SearchScreen({
    super.key,
    required this.addToCart,
    required this.toggleFavorite,
    required this.favorites,
  });

  @override
  State<SearchScreen>
      createState() =>
          _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {
  String search = "";

  @override
  Widget build(
    BuildContext context,
  ) {
    final result =
        foods.where((food) {
      final query =
          search.toLowerCase();

      return food.name
              .toLowerCase()
              .contains(query) ||
          food.category
              .toLowerCase()
              .contains(query);
    }).toList();

    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Column(
          children: [
            const Text(
              "Search Food",

              style:
                  TextStyle(
                fontSize: 25,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },

              decoration:
                  InputDecoration(
                hintText:
                    "Search pizza, biryani...",

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                suffixIcon:
                    search.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                search =
                                    "";
                              });
                            },

                            icon:
                                const Icon(
                              Icons.clear,
                            ),
                          ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Expanded(
              child: result.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [
                          Icon(
                            Icons
                                .search_off,
                            size: 65,
                            color:
                                Colors.grey,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Text(
                            "No food found",
                            style:
                                TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          result.length,

                      itemBuilder:
                          (context, index) {
                        final food =
                            result[index];

                        final isFavorite =
                            widget
                                .favorites
                                .contains(
                          food,
                        );

                        return Card(
                          child:
                              ListTile(
                            leading:
                                CircleAvatar(
                              radius: 30,

                              backgroundImage:
                                  NetworkImage(
                                food.image,
                              ),
                            ),

                            title:
                                Text(
                              food.name,
                            ),

                            subtitle:
                                Text(
                              "₹${food.price.toInt()} "
                              "• ⭐ ${food.rating} "
                              "• ${food.deliveryMinutes} min",
                            ),

                            trailing:
                                Row(
                              mainAxisSize:
                                  MainAxisSize.min,

                              children: [
                                IconButton(
                                  onPressed:
                                      () {
                                    widget
                                        .toggleFavorite(
                                      food,
                                    );
                                  },

                                  icon:
                                      Icon(
                                    isFavorite
                                        ? Icons
                                            .favorite
                                        : Icons
                                            .favorite_border,

                                    color:
                                        isFavorite
                                            ? Colors.red
                                            : null,
                                  ),
                                ),

                                IconButton(
                                  onPressed:
                                      () {
                                    widget
                                        .addToCart(
                                      food,
                                    );
                                  },

                                  icon:
                                      const Icon(
                                    Icons
                                        .add_shopping_cart,

                                    color:
                                        Colors.deepOrange,
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
      ),
    );
  }
}

// ============================================================
// FAVORITE SCREEN
// ============================================================

class FavoriteScreen
    extends StatelessWidget {
  final List<Food> favorites;
  final ValueChanged<Food> addToCart;
  final ValueChanged<Food> toggleFavorite;

  const FavoriteScreen({
    super.key,
    required this.favorites,
    required this.addToCart,
    required this.toggleFavorite,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const Text(
              "My Favorites ❤️",

              style:
                  TextStyle(
                fontSize: 25,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Expanded(
              child: favorites.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [
                          Icon(
                            Icons
                                .favorite_border,
                            size: 70,
                            color:
                                Colors.grey,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Text(
                            "No favorite food yet",
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          favorites.length,

                      itemBuilder:
                          (context, index) {
                        final food =
                            favorites[index];

                        return Card(
                          child:
                              ListTile(
                            leading:
                                CircleAvatar(
                              radius: 30,

                              backgroundImage:
                                  NetworkImage(
                                food.image,
                              ),
                            ),

                            title:
                                Text(
                              food.name,
                            ),

                            subtitle:
                                Text(
                              "₹${food.price.toInt()} "
                              "• ${food.deliveryMinutes} min",
                            ),

                            trailing:
                                Row(
                              mainAxisSize:
                                  MainAxisSize.min,

                              children: [
                                IconButton(
                                  onPressed:
                                      () {
                                    toggleFavorite(
                                      food,
                                    );
                                  },

                                  icon:
                                      const Icon(
                                    Icons
                                        .favorite,
                                    color:
                                        Colors.red,
                                  ),
                                ),

                                IconButton(
                                  onPressed:
                                      () {
                                    addToCart(
                                      food,
                                    );
                                  },

                                  icon:
                                      const Icon(
                                    Icons
                                        .add_shopping_cart,
                                    color:
                                        Colors.deepOrange,
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
      ),
    );
  }
}