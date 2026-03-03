import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0D4F2B),
                const Color(0xFF1A7A4A),
                colorScheme.surface,
              ],
              stops: const [0.0, 0.2, 0.4],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Custom App Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.educationTitle,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Tab Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white.withOpacity(0.5),
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.book_rounded, size: 20),
                              const SizedBox(width: 8),
                              Text(AppLocalizations.of(context)!.learnTab),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.quiz_rounded, size: 20),
                              const SizedBox(width: 8),
                              Text(AppLocalizations.of(context)!.quizTab),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tab Content
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                    child: const TabBarView(
                      children: [
                        LearnTab(),
                        QuizTab(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LearnTab extends StatelessWidget {
  const LearnTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Map<String, dynamic>> diseases = [
      {
        "name": "Maize (Corn)",
        "emoji": "🌽",
        "color": const Color(0xFFF9A825),
        "description": "Maize is a staple food crop in Kenya and many parts of the world. It is a tall cereal grass that bears grain on large ears. Maintaining maize health is critical for food security.",
        "details": [
          {
            "title": "Maize Streak Virus (MSV)",
            "image": "assets/images/maize_streak_virus.png",
            "symptoms": "Yellow streaks running parallel to leaf veins. Symptoms start as small, circular to elongate, chlorotic spots on the lowest exposed portion of the leaf. These spots expand and fuse to form long, narrow chlorotic streaks. Severely affected plants are stunted and may fail to produce ears.",
            "prevention": "Control leafhoppers (the primary vector), plant resistant hybrids, and practice early planting to avoid peak insect populations. Remove volunteer plants that might harbor the virus between seasons.",
          },
          {
            "title": "Gray Leaf Spot (GLS)",
            "image": "assets/images/maize_gray_leaf_spot.png",
            "symptoms": "Rectangular, tan-to-gray spots on leaves that are restricted by veins. The lesions are usually 1-5 cm long and 2-4 mm wide. In humid conditions, the lesions may appear 'fuzzy' due to fungal sporulation. Heavy infection can lead to leaf death and stalk rot.",
            "prevention": "Crop rotation with non-host crops (like legumes), tilling to bury infected residue, and using resistant maize varieties. Avoid high-density planting to improve airflow.",
          },
          {
            "title": "Common Rust",
            "symptoms": "Cinnamon-brown pustules on both upper and lower leaf surfaces. These pustules are circular to elongate and appear reddish-brown. When the pustules rupture, they release powdery spores. Infected leaves may turn yellow and die early.",
            "prevention": "Use resistant hybrids. Fungicides can be effective but are often not economically viable for small-scale farmers unless the infection is severe and occurs early in the season.",
          }
        ],
      },
      {
        "name": "Cabbage",
        "emoji": "🥬",
        "color": const Color(0xFF4CAF50),
        "description": "Cabbage is a leafy green or purple biennial plant grown as an annual vegetable crop for its dense-leaved heads. It is a cool-season crop that is highly nutritious.",
        "details": [
          {
            "title": "Black Rot",
            "image": "assets/images/cabbage_black_rot.png",
            "symptoms": "V-shaped yellow lesions on leaf margins. The veins within the yellow area turn black. As the disease progresses, the yellowed areas turn brown and the leaves eventually die. The blackening can also spread into the stem and heart of the cabbage.",
            "prevention": "Use certified disease-free seeds and seedlings. Practice at least a 3-year crop rotation with non-cruciferous plants. Remove and destroy infected plant debris immediately.",
          },
          {
            "title": "Cabbage Looper (Pest)",
            "image": "assets/images/cabbage_looper.png",
            "symptoms": "Large, irregular holes in leaves caused by green caterpillars. The caterpillars have a characteristic 'looping' motion when they move. They can also mine into the development head of the cabbage, making it unmarketable.",
            "prevention": "Hand-pick loopers if the infestation is small. Use floating row covers to prevent moths from laying eggs. Encourage natural predators like lacewings and parasitic wasps. Bt (Bacillus thuringiensis) can be used as an organic insecticide.",
          },
          {
            "title": "Downy Mildew",
            "symptoms": "Yellow spots on the upper leaf surface with a fluffy white growth on the corresponding underside. In cool, moist weather, the spots can enlarge and turn brown. Seedlings are particularly susceptible and may die if infected early.",
            "prevention": "Improve air circulation through proper spacing and weed control. Avoid overhead irrigation, especially late in the day. Use resistant varieties whenever possible.",
          }
        ],
      },
      {
        "name": "Sukuma Wiki (Kale)",
        "emoji": "🥬",
        "color": const Color(0xFF1B5E20),
        "description": "Sukuma Wiki is a resilient, nutritious kale variety that is a staple in East African cuisine. It is known for its ability to grow in varied conditions and provide continuous harvests.",
        "details": [
          {
            "title": "Black Spot (Alternaria)",
            "image": "assets/images/sukuma_wiki_black_spot.png",
            "symptoms": "Small, dark, circular spots on leaves that may develop concentric rings. In humid conditions, these spots can expand and lead to significant leaf loss. The center of the spots may eventually drop out, leaving a 'shot-hole' appearance.",
            "prevention": "Avoid overhead watering to keep foliage dry. Remove lower leaves that show signs of infection. Practice crop rotation and maintain healthy soil through organic fertilization.",
          },
          {
            "title": "Aphids (Pest)",
            "image": "assets/images/sukuma_wiki_aphids.png",
            "symptoms": "Small, soft-bodied insects (usually green or black) clustered on the undersides of leaves and developing buds. They cause leaf curling, yellowing, and stunted growth. They also secrete a sticky liquid called honeydew, which can lead to sooty mold.",
            "prevention": "Blast aphids off with a strong stream of water. Use neem oil or insecticidal soap for larger infestations. Attract beneficial insects like ladybugs that feed on aphids.",
          },
          {
            "title": "Powdery Mildew",
            "symptoms": "White, powdery patches on the surface of leaves. As the infection spreads, the leaves may turn yellow and curl. This disease is most common during warm, dry days followed by cool, humid nights.",
            "prevention": "Ensure plants have adequate spacing for sunlight and airflow. Apply sulfur-based fungicides or bake a baking soda solution (1 tsp baking soda + 1 quart water + a few drops of dish soap) as an organic treatment.",
          }
        ],
      },
      {
        "name": "Tomato",
        "emoji": "🍅",
        "color": const Color(0xFFD32F2F),
        "description": "Tomatoes are widely cultivated for their edible fruits. They are susceptible to several fungal and viral diseases that can significantly impact yield.",
        "details": [
          {
            "title": "Tomato Early Blight",
            "symptoms": "Dark spots with concentric rings on older leaves. The spots often have a yellow halo. If left untreated, the disease causes leaves to drop, exposing fruits to sunscald.",
            "prevention": "Crop rotation, staking to keep fruit off the ground, and mulching to prevent soil-borne spores from splashing onto leaves.",
          }
        ],
      },
      {
        "name": "Potato",
        "emoji": "🥔",
        "color": const Color(0xFF5D4037),
        "description": "Potatoes are an important tuber crop. Blights are the most devastating diseases affecting potato production globally.",
        "details": [
          {
            "title": "Potato Late Blight",
            "symptoms": "Water-soaked irregular spots on leaves, rapidly enlarging into large dark brown lesions. In humid weather, a white fungal growth may appear on the underside of the leaves. This disease can destroy a whole field in days.",
            "prevention": "Use resistant varieties, eliminate cull piles, and avoid planting near tomatoes or other host plants.",
          }
        ],
      },
    ];

    return ListView.builder(
      itemCount: diseases.length,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      itemBuilder: (context, index) {
        final d = diseases[index];
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOut,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (d["color"] as Color).withOpacity(0.2),
                      (d["color"] as Color).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(d["emoji"], style: const TextStyle(fontSize: 28)),
                ),
              ),
              title: Text(
                d["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.2,
                ),
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.tapToLearn,
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              children: [
                if (d["description"] != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (d["color"] as Color).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      d["description"],
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                ...(d["details"] as List<Map<String, String>>).map((detail) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: d["color"],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                detail["title"]!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (detail["image"] != null) ...[
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              detail["image"]!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceVariant,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.image_not_supported_rounded),
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        _InfoSection(
                          title: AppLocalizations.of(context)!.symptoms,
                          content: detail["symptoms"]!,
                          icon: Icons.sick_rounded,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(height: 12),
                        _InfoSection(
                          title: AppLocalizations.of(context)!.prevention,
                          content: detail["prevention"]!,
                          icon: Icons.shield_rounded,
                          color: Colors.green.shade600,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );


  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const _InfoSection({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  State<QuizTab> createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  int _score = 0;
  int _questionIndex = 0;
  bool _showScore = false;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'What causes Early Blight in tomatoes?',
      'answers': [
        {'text': 'Fungus', 'score': 1},
        {'text': 'Virus', 'score': 0},
        {'text': 'Bacteria', 'score': 0},
      ] as List<Map<String, Object>>,
    },
    {
      'question': 'Which method helps prevent Maize Streak Virus?',
      'answers': [
        {'text': 'Overwatering', 'score': 0},
        {'text': 'Controlling Leafhoppers', 'score': 1},
        {'text': 'Adding more Nitrogen', 'score': 0},
      ] as List<Map<String, Object>>,
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex++;
      if (_questionIndex >= _questions.length) {
        _showScore = true;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _questionIndex = 0;
      _showScore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_showScore) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
                child: const Center(
                  child: Text('🎉', style: TextStyle(fontSize: 48)),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.quizCompleted,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${AppLocalizations.of(context)!.score} $_score / ${_questions.length}',
                style: TextStyle(
                  fontSize: 20,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _resetQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.restartQuiz,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) return const SizedBox.shrink();

    final question = _questions[_questionIndex];
    final answers = question['answers'] as List<Map<String, Object>>;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          // Progress
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${AppLocalizations.of(context)!.question} ${_questionIndex + 1}/${_questions.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            question['question'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 36),
          ...answers.map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Material(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () => _answerQuestion(answer['score'] as int),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
                    ),
                    child: Text(
                      answer['text'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
