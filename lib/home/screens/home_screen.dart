import 'package:flutter/material.dart';
import '../../profile/profile_screen.dart';
import '../models/quote_model.dart';
import '../models/category_model.dart';
import '../widgets/category_chip.dart';
import '../widgets/daily_quote_card.dart';
import '../widgets/quote_card.dart';
import '../providers/home_repository.dart';
import '../widgets/quote_of_day_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repo = HomeRepository();
  final searchController = TextEditingController();

  String? selectedCategory;
  int _currentIndex = 0;

  late Future<Quote> quoteOfDay;
  late Future<List<Category>> categories;
  late Future<List<Quote>> quotes;

  @override
  void initState() {
    super.initState();
    quoteOfDay = repo.fetchQuoteOfTheDay();
    categories = repo.fetchCategories();
    quotes = repo.fetchQuotes();
  }

  void _reloadQuotes() {
    setState(() {
      quotes = repo.fetchQuotes(
        category: selectedCategory,
        search: searchController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        title: const Icon(
          Icons.format_quote_sharp,
          size: 36,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () => _showSearchDialog(),
        //   )
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _reloadQuotes();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Quote of the day
              FutureBuilder<Quote>(
                future: quoteOfDay,
                builder: (_, snap) {
                  if (!snap.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return QuoteOfDayCard(
                    quote: snap.data!,
                   // isFeatured: true,
                  );
                },
              ),

              const SizedBox(height: 30),
              const Text('Explore Categories',
                  style: TextStyle(color: Colors.white70)),

              const SizedBox(height: 12),

              /// Categories (FROM SUPABASE)
              FutureBuilder<List<Category>>(
                future: categories,
                builder: (_, snap) {
                  if (!snap.hasData) return const SizedBox();
                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: snap.data!.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(width: 10),
                      itemBuilder: (_, i) {
                        final cat = snap.data![i].name;
                        final active = cat == selectedCategory;
                        return CategoryChip(
                          label: cat,
                          selected: active,
                          onTap: () {
                            selectedCategory =
                              active ? null : cat;
                              _reloadQuotes();
                          },
                          // onSelected: (_) {
                          //   selectedCategory =
                          //   active ? null : cat;
                          //   _reloadQuotes();
                          // },
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
              const Text('Daily Feed',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),

              /// Quotes Feed
              FutureBuilder<List<Quote>>(
                future: quotes,
                builder: (_, snap) {
                  if (!snap.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snap.data!.isEmpty) {
                    return const Text(
                      'No quotes found',
                      style: TextStyle(color: Colors.white60),
                    );
                  }

                  return Column(
                    children: snap.data!
                        .map((q) => DailyQuoteCard(quote: q))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // ✅ BOTTOM NAV BAR ADDED BACK
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Navigation handling (later screens)
          if (index == 1) {
            // TODO: Navigate to Discover/Search
          } else if (index == 2) {
            // Navigator.push(context,
            // MaterialPageRoute(builder:(context) => ProfileScreen(),),
            // );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ),
            );
          }
        },
        backgroundColor: const Color(0xFF0E1625),
        selectedItemColor: const Color(0xFF1A5CFF),
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Vault',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Search Quotes'),
        content: TextField(
          controller: searchController,
          decoration:
          const InputDecoration(hintText: 'Search keyword'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _reloadQuotes();
            },
            child: const Text('Search'),
          )
        ],
      ),
    );
  }
}
