import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/quiz.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/second') {
          // Extract the username from arguments
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => Simple_quiz(username: args),
          );
        }
        return null;
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(139, 150, 132, 171),
        ),
        // used to customize the borders of the input area
        borderRadius: BorderRadius.all(Radius.circular(50)));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(239, 239, 11, 80),
        title: const Text(
          'Quiz',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: 300,
            height: 300,
            color: Colors.white.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign up/Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 05),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        filled: true,
                        fillColor: Color.fromARGB(31, 87, 84, 84),
                        focusedBorder: border,
                        enabledBorder: border,
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  SizedBox(height: 05),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        filled: true,
                        fillColor: Color.fromARGB(31, 87, 84, 84),
                        focusedBorder: border,
                        enabledBorder: border,
                      ),
                      keyboardType: TextInputType.name,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      String username = usernameController.text.trim();
                      String password = passwordController.text.trim();
                      if (username.isNotEmpty && password.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Simple_quiz(username: username),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter both username and password'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(238, 249, 34, 98),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
