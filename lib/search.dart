import 'package:flutter/material.dart';
import 'date_selection.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key});

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = "Benin";

  final List<String> cities = [
    "Cotonou",
    "Ouidah",
    "Porto Novo",
    "Parakou",
    "Abomey",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar custom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.brown),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.brown,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.brown,
                      indicatorWeight: 2,
                      tabs: const [
                        Tab(text: "Séjours"),
                        Tab(text: "Experiences"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Champ recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: TextEditingController(text: searchQuery),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.brown),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, color: Colors.brown),
                      onPressed: () {
                        setState(() {
                          searchQuery = "";
                        });
                      },
                    ),
                    border: InputBorder.none,
                    hintText: "Rechercher",
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Liste villes
            Expanded(
              child: ListView.builder(
                itemCount: cities.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.brown,
                        size: 28,
                      ),
                      title: Text(
                        cities[index],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.brown,
                        ),
                      ),
                      onTap: () async {
                        // Naviguer vers la page de sélection de dates
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => DateSelectionPage(
                                  destination: cities[index],
                                ),
                          ),
                        );

                        if (result != null) {
                          // Retourner le résultat complet à explore.dart
                          Navigator.pop(context, result);
                        }
                      },
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
