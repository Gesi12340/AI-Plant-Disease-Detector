import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plant Education'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book), text: 'Learn'),
              Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LearnTab(),
            QuizTab(),
          ],
        ),
      ),
    );
  }
}

class LearnTab extends StatelessWidget {
  const LearnTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> diseases = const [
      {
        "name": "Tomato Early Blight",
        "symptoms": "Dark spots with concentric rings on older leaves.",
        "prevention": "Crop rotation, staking, and mulching."
      },
      {
        "name": "Potato Late Blight",
        "symptoms": "Water-soaked irregular spots on leaves, rapidly enlarging.",
        "prevention": "Use resistant varieties, eliminate cull piles."
      },
      {
        "name": "Maize Streak Virus",
        "symptoms": "Yellow streaks running parallel to leaf veins.",
        "prevention": "Control leafhoppers, plant resistant hybrids."
      },
    ];

    return ListView.builder(
      itemCount: diseases.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final d = diseases[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              d["name"]!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("Tap to learn more"),
            leading: const Icon(Icons.grass, color: Colors.green),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Symptoms:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold)),
                    Text(d["symptoms"]!),
                    const SizedBox(height: 10),
                    Text("Prevention:",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold)),
                    Text(d["prevention"]!),
                  ],
                ),
              )
            ],
          ),
        );
      },
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
    if (_showScore) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Score: $_score / ${_questions.length}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetQuiz,
              child: const Text('Restart Quiz'),
            )
          ],
        ),
      );
    }
    
    // Safety check
    if (_questions.isEmpty) return const SizedBox.shrink();

    final question = _questions[_questionIndex];
    final answers = question['answers'] as List<Map<String, Object>>;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${_questionIndex + 1}/${_questions.length}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text(
            question['question'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ...answers.map((answer) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: FilledButton.tonal(
                onPressed: () => _answerQuestion(answer['score'] as int),
                child: Text(answer['text'] as String),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
