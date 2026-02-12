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
        "name": "Tomato Early Blight",
        "emoji": "🍅",
        "color": const Color(0xFFD32F2F),
        "symptoms": "Dark spots with concentric rings on older leaves.",
        "prevention": "Crop rotation, staking, and mulching.",
      },
      {
        "name": "Potato Late Blight",
        "emoji": "🥔",
        "color": const Color(0xFF5D4037),
        "symptoms": "Water-soaked irregular spots on leaves, rapidly enlarging.",
        "prevention": "Use resistant varieties, eliminate cull piles.",
      },
      {
        "name": "Maize Streak Virus",
        "emoji": "🌽",
        "color": const Color(0xFFF9A825),
        "symptoms": "Yellow streaks running parallel to leaf veins.",
        "prevention": "Control leafhoppers, plant resistant hybrids.",
      },
    ];

    return ListView.builder(
      itemCount: diseases.length,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      itemBuilder: (context, index) {
        final d = diseases[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (d["color"] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(d["emoji"], style: const TextStyle(fontSize: 24)),
                ),
              ),
              title: Text(
                d["name"],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.tapToLearn,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              children: [
                _InfoSection(
                  title: AppLocalizations.of(context)!.symptoms,
                  content: d["symptoms"],
                  icon: Icons.sick_rounded,
                  color: Colors.red,
                ),
                const SizedBox(height: 10),
                _InfoSection(
                  title: AppLocalizations.of(context)!.prevention,
                  content: d["prevention"],
                  icon: Icons.shield_rounded,
                  color: Colors.green,
                ),
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
