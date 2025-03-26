import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopmentScreen extends StatelessWidget {
  const DevelopmentScreen({super.key});

  // Function to open URLs
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Development"),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("🚀 Development Process"),
            _buildDevelopmentCard(
              title: "🔹 Tech Stack",
              description: "Built using Flutter, Firebase, Supabase, and Blockchain for transparency.",
              icon: Icons.build,
            ),
            _buildDevelopmentCard(
              title: "🔹 Version",
              description: "RaiseIt v1.0.0",
              icon: Icons.code,
            ),
            _buildDevelopmentCard(
              title: "🔹 Roadmap",
              description: "Future updates: enhanced security, real-time analytics, and expanded blockchain integration.",
              icon: Icons.timeline,
            ),
            const SizedBox(height: 20),

            _buildSectionTitle("👨‍💻 Developers"),
            _buildDeveloperCard(
              name: "Maxwell Muthee",
              githubUrl: "https://github.com/Maxmuthee",
            ),
            _buildDeveloperCard(
              name: "Solomon Njogo",
              githubUrl: "https://github.com/solomon-njogo",
            ),

            const SizedBox(height: 20),
            _buildSectionTitle("📂 Project Repository"),
            InkWell(
              onTap: () => _launchURL("https://github.com/solomon-njogo/RaiseIt.git"),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.link, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      "GitHub: RaiseIt Project",
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _buildDevelopmentCard({required String title, required String description, required IconData icon}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue[900], size: 30),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ),
    );
  }

  Widget _buildDeveloperCard({required String name, required String githubUrl}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.blue),
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: IconButton(
          icon: const Icon(Icons.link, color: Colors.blue),
          onPressed: () => _launchURL(githubUrl),
        ),
      ),
    );
  }
}
