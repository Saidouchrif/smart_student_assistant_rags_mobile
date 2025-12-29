import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("À propos"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ===== IMAGE UNIVERSITÉ =====
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/ecole-image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== TITRE =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Université Mundiapolis",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const SizedBox(height: 8),

            // ===== DESCRIPTION =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "L’Université Mundiapolis est une université privée marocaine "
                "reconnue pour son excellence académique et son approche innovante "
                "dans les domaines de l’ingénierie, du management et des sciences "
                "informatiques.\n\n"
                "Elle met l’accent sur la pratique, l’employabilité et "
                "l’adaptation aux besoins du marché professionnel.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),

            const SizedBox(height: 25),

            // ===== CARD INFOS =====
            _infoCard(
              context,
              icon: Icons.school,
              title: "Formation",
              value: "Ingénierie, Informatique, Management",
            ),

            _infoCard(
              context,
              icon: Icons.location_on,
              title: "Localisation",
              value: "Casablanca, Maroc",
            ),

            _infoCard(
              context,
              icon: Icons.language,
              title: "Site web",
              value: "www.mundiapolis.ma",
            ),

            const SizedBox(height: 30),

            // ===== SECTION ÉTUDIANT =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage("images/profile.png"),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Said Ouchrif",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Étudiant – Développeur Flutter",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Application développée par l’étudiant Said Ouchrif "
                        "dans un cadre pédagogique à l’Université Mundiapolis.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ===== WIDGET CARD RÉUTILISABLE =====
  static Widget _infoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
