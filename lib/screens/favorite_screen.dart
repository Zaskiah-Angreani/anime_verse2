import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/favorite_anime_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // 1. Controller untuk mengelola input pencarian di FavoriteScreen
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  // 2. Membersihkan controller saat widget di-dispose (mencegah memory leak)
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Anime",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          // Ambil daftar favorit yang sudah terfilter query pencarian favorit
          final filteredFavorites = provider.getFilteredFavorites();

          return Column(
            children: [
              // Search Bar Section
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.075),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: screenWidth * 0.02,
                        offset: Offset(0, screenHeight * 0.005),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController, // Hubungkan ke controller
                    onChanged: (value) {
                      // Update query pencarian favorit di AppStateProvider
                      provider.setFavoriteSearchQuery(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search Favorite",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.04,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: screenWidth * 0.06,
                      ),
                      // Tombol Hapus (Clear Button) jika ada teks di search bar favorit
                      suffixIcon: provider.favoriteSearchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white),
                        onPressed: () {
                          _searchController.clear();
                          provider.setFavoriteSearchQuery("");
                        },
                      )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.075),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0b395e),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              // Favorite Anime List / Empty State
              Expanded(
                child: filteredFavorites.isEmpty
                    ? Center(
                  child: Text(
                    'No Favorite Anime',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                    : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                  ),
                  itemCount: filteredFavorites.length,
                  itemBuilder: (context, index) {
                    final anime = filteredFavorites[index];
                    return FavoriteAnimeCard(
                      id: anime.id, // Kirimkan id anime
                      title: anime.title,
                      genre: anime.genre,
                      rating: anime.rating,
                      imagePath: anime.imagePath,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}