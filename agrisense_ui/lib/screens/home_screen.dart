import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Full Screen Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboardingBG.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Main Layout (Fixed Top Bar + Scrollable Content)
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                // --- FIXED TOP APP BAR ---
                // This stays at the top and never scrolls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Notification Icon
                      IconButton(
                        onPressed: () {
                          print("Notifications clicked");
                        },
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(), // Removes default extra padding
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      // Profile Icon
                      GestureDetector(
                        onTap: () {
                          print("Profile clicked");
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 18,
                          child: Icon(
                            Icons.person_outline,
                            color: Color(0xFF0B2B1D),
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- SCROLLABLE MAIN CONTENT ---
                // This area will scroll if the phone is too small to fit everything
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Greeting
                          const Text(
                            'Hi Eshan,',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Keep your field operations running smoothly.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Weather Cards Row
                          Row(
                            children: [
                              Expanded(
                                child: _buildWeatherCard(
                                  "SUN",
                                  Icons.cloud_outlined,
                                  "16°",
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildWeatherCard(
                                  "MON",
                                  Icons.water_drop_outlined,
                                  "17°",
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildWeatherCard(
                                  "THU",
                                  Icons.thunderstorm_outlined,
                                  "18°",
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildWeatherCard(
                                  "WED",
                                  Icons.cloudy_snowing,
                                  "19°",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Ask AI Banner
                          GestureDetector(
                            onTap: () {
                              print("Ask AI clicked");
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFE8F5E9),
                                    Color(0xFFA5D6A7),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Need Expert Advice?",
                                    style: TextStyle(
                                      color: Color(0xFF081C15),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "Detect risks early and protect your yield",
                                    style: TextStyle(
                                      color: Color(0xFF081C15),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      Text(
                                        "Ask AI",
                                        style: TextStyle(
                                          color: Color(0xFF081C15),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Color(0xFF081C15),
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Your AI Insights Section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFE8F5E9), Color(0xFFA5D6A7)],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Your AI Insights",
                                  style: TextStyle(
                                    color: Color(0xFF081C15),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Revisit past diagnoses and field recommendations",
                                  style: TextStyle(
                                    color: Color(0xFF081C15),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Insights List
                                // shrinkWrap tells the list to take exactly as much space as it needs
                                // NeverScrollableScrollPhysics ensures it scrolls smoothly with the rest of the page
                                ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  children: [
                                    _buildInsightTile(
                                      "yellow leaves on rice plants",
                                      "Usually indicates nitrogen deficiency or overwatering...",
                                    ),
                                    const SizedBox(height: 10),
                                    _buildInsightTile(
                                      "rice blast fungus signs in seedlings",
                                      "White or gray lesions with dark borders on leaves. Controlled with ...",
                                    ),
                                    const SizedBox(height: 10),
                                    _buildInsightTile(
                                      "white streaks on rice leaves disease",
                                      "Could be rice tungro virus. Managed by controlling vector insects...",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // This massive empty box acts as a spacer at the very bottom
                          // It ensures the user can scroll the lowest card up and clear the floating nav bar!
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Floating Bottom Navigation Bar (Fixed in place)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.home_outlined, 0),
                    _buildNavItem(Icons.chat_bubble_outline, 1),
                    _buildNavItem(Icons.cloud_outlined, 2),
                    _buildNavItem(Icons.person_outline, 3),
                    _buildNavItem(Icons.settings_outlined, 4),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildWeatherCard(String day, IconData icon, String temp) {
    return GestureDetector(
      onTap: () => print("$day Weather clicked"),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFD8F3DC),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              day,
              style: const TextStyle(
                color: Color(0xFF081C15),
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 12),
            Icon(icon, color: const Color(0xFF081C15), size: 24),
            const SizedBox(height: 12),
            Text(
              temp,
              style: const TextStyle(
                color: Color(0xFF081C15),
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightTile(String title, String subtitle) {
    return GestureDetector(
      onTap: () => print("Insight clicked: $title"),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF081C15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        print("Navigated to tab $index");
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Icon(
          icon,
          color: isActive
              ? const Color(0xFF081C15)
              : const Color(0xFF081C15).withOpacity(0.6),
          size: 28,
        ),
      ),
    );
  }
}
