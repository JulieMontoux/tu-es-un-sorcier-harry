import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, int> scores;

  const ResultScreen({super.key, required this.scores});

  String getTopHouse() {
    String topHouse = scores.keys.first;
    int topScore = 0;
    scores.forEach((house, score) {
      if (score > topScore) {
        topScore = score;
        topHouse = house;
      }
    });
    return topHouse;
  }

  @override
  Widget build(BuildContext context) {
    final result = getTopHouse();

    final colors = {
      "GPTaigle": const Color(0xFF3D9BFF),   // bleu magique
      "Geminiard": const Color(0xFFB043FF), // violet néon
      "Copilouffle": const Color(0xFFFFB84C), // or doux
      "Llamador": const Color(0xFFFF4C4C),  // rouge intense
    };

    final messages = {
      "GPTaigle": "📘 Curieux et réfléchi, tu es un GPTaigle !",
      "Geminiard": "🎭 Créatif et adaptable, bienvenue chez les Geminiard !",
      "Copilouffle": "💛 Généreux et loyal, tu es un Copilouffle !",
      "Llamador": "🔥 Ambitieux et puissant, tu es un Llamador !",
    };

    // 🧮 Convertit les scores en un total pour le graphique
    final total = scores.values.fold<int>(0, (sum, item) => sum + item);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colors[result]!, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  messages[result]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),

                // 🎯 Diagramme circulaire
                SizedBox(
                  height: 220,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 40,
                      sectionsSpace: 4,
                      sections: scores.entries.map((entry) {
                        final percentage = total == 0
                            ? 0
                            : (entry.value / total * 100).toStringAsFixed(1);
                        return PieChartSectionData(
                          color: colors[entry.key],
                          value: entry.value.toDouble(),
                          title: "${entry.key[0]}: $percentage%",
                          radius: 80,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 🟡 Bouton Rejouer
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text("Rejouer"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
