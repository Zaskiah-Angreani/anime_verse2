import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/anime.dart';
import '../widgets/app_scaffold.dart';

class DetailScreen extends StatelessWidget {
  final String animeId;

  const DetailScreen({
    super.key,
    required this.animeId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Cari anime berdasarkan animeId dari DummyData
    final anime = DummyData.animeList.firstWhere(
          (element) => element.id == animeId,
      orElse: () => DummyData.animeList.first,
    );

    return AppScaffold(
      body: CustomScrollView(
        slivers: [
          // Header section dengan gambar dan judul
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: screenHeight * 0.3,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gambar Background Anime
                  Image.asset(
                    anime.imagePath,
                    fit: BoxFit.cover,
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // Judul dan Genre di bagian bawah gambar
                  Positioned(
                    bottom: screenHeight * 0.02,
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          anime.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          anime.genre,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Content section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Rating, Episode, dan Favorit
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Rating
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: screenWidth * 0.02,
                                offset: Offset(0, screenHeight * 0.005),
                              ),
                            ],
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: screenWidth * 0.04,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                anime.rating,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Total Episodes
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0b395e),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: screenWidth * 0.02,
                                offset: Offset(0, screenHeight * 0.005),
                              ),
                            ],
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Text(
                            '${anime.totalEpisodes} Episodes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Add to Favorites
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: screenWidth * 0.02,
                                offset: Offset(0, screenHeight * 0.005),
                              ),
                            ],
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: screenWidth * 0.04,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                'Add to Favorites',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Title Synopsis
                  Text(
                    'Synopsis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  // Text Synopsis
                  Text(
                    anime.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: screenWidth * 0.038,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}