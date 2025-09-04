import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 🔹 Widget racine
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(), // ← page principale avec navigation
    );
  }
}

// 🔹 Page principale avec BottomNavigationBar
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Liste des pages
  final List<Widget> _pages = const [
    Page1(),
    Page2(),
    Page3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            label: "Page 1",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two),
            label: "Page 2",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_3),
            label: "Page 3",
          ),
        ],
      ),
    );
  }
}

// 🔹 Page 1 (tes boutons par exemple)
class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  String _lastClicked = "Aucun bouton";

  void _onButtonPressed(String buttonName) {
    setState(() {
      _lastClicked = buttonName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 1 - Boutons"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _onButtonPressed("Elevated Button"),
              child: const Text("Elevated Button"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => _onButtonPressed("Text Button"),
              child: const Text("Text Button"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => _onButtonPressed("Outlined Button"),
              child: const Text("Outlined Button"),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.red, size: 40),
              onPressed: () => _onButtonPressed("Icon Button (Heart)"),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () => _onButtonPressed("Floating Action Button"),
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              hint: const Text("Select an option"),
              items: <String>["Option 1", "Option 2", "Option 3"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _onButtonPressed("Dropdown: $value");
                }
              },
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Colors.blue,
              onPressed: () => _onButtonPressed("Cupertino Button"),
              child: const Text("Cupertino Button"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(12),
        child: Text(
          "Vous avez cliqué sur : $_lastClicked",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// 🔹 Page 2 — Calculatrice simple
class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final _n1Ctrl = TextEditingController(text: "");
  final _n2Ctrl = TextEditingController(text: "");
  String _resultText = ""; // résultat affiché

  @override
  void dispose() {
    _n1Ctrl.dispose();
    _n2Ctrl.dispose();
    super.dispose();
  }

  double? _parse(String s) => double.tryParse(s.trim().replaceAll(",", "."));

  void _calc(String op) {
    final a = _parse(_n1Ctrl.text);
    final b = _parse(_n2Ctrl.text);

    if (a == null || b == null) {
      setState(() => _resultText = "Entrez deux nombres valides.");
      return;
    }
    double res;
    switch (op) {
      case "add":
        res = a + b;
        break;
      case "sub":
        res = a - b;
        break;
      case "mul":
        res = a * b;
        break;
      case "div":
        if (b == 0) {
          setState(() => _resultText = "Division par zéro interdite.");
          return;
        }
        res = a / b;
        break;
      default:
        return;
    }
    setState(() => _resultText = "Résultat : $res");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Form"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Nombre 1"),
            TextField(
              controller: _n1Ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Ex: 22",
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Nombre 2"),
            TextField(
              controller: _n2Ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Ex: 44",
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Ligne de boutons (Wrap pour s'adapter aux petits écrans)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _calc("add"),
                  child: const Text("Addition"),
                ),
                OutlinedButton(
                  onPressed: () => _calc("sub"),
                  child: const Text("Soustraction"),
                ),
                OutlinedButton(
                  onPressed: () => _calc("mul"),
                  child: const Text("Multiplication"),
                ),
                OutlinedButton(
                  onPressed: () => _calc("div"),
                  child: const Text("Division"),
                ),
              ],
            ),

            const SizedBox(height: 16),
            if (_resultText.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _resultText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Page 3 — Calculatrice (Stateful, une seule méthode)
class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final _n1Ctrl = TextEditingController();
  final _n2Ctrl = TextEditingController();

  String _op = "add";           // add | sub | mul | div
  String _resultText = "";      // Résultat affiché

  @override
  void dispose() {
    _n1Ctrl.dispose();
    _n2Ctrl.dispose();
    super.dispose();
  }

  double? _parse(String s) => double.tryParse(
    s.trim().replaceAll(",", "."), // accepte virgule
  );

  void _calculate() {
    final a = _parse(_n1Ctrl.text);
    final b = _parse(_n2Ctrl.text);

    if (a == null || b == null) {
      setState(() => _resultText = " Entrez deux nombres valides.");
      return;
    }

    double res;
    switch (_op) {
      case "add":
        res = a + b;
        break;
      case "sub":
        res = a - b;
        break;
      case "mul":
        res = a * b;
        break;
      case "div":
        if (b == 0) {
          setState(() => _resultText = " Division par zéro.");
          return;
        }
        res = a / b;
        break;
      default:
        return;
    }
    setState(() => _resultText = "Résultat : $res");
  }

  Widget _radio(String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: _op,
          onChanged: (v) => setState(() => _op = v!),
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculatrice"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Champs
            TextField(
              controller: _n1Ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Nombre 1",
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _n2Ctrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Nombre 2",
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Radios
            const Divider(),
            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                _radio("add", "Addition"),
                _radio("sub", "Soustraction"),
                _radio("mul", "Multiplication"),
                _radio("div", "Division"),
              ],
            ),
            const SizedBox(height: 16),

            // Bouton Caluler
            Center(
              child: ElevatedButton(
                onPressed: _calculate,
                child: const Text("Calculer"),
              ),
            ),
            const SizedBox(height: 12),

            // Résultat
            if (_resultText.isNotEmpty)
              Center(
                child: Text(
                  _resultText,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

