import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:blindreader/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart' as audioplayers;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homepage': (context) => const Homepage(),
        '/editAcc': (context) => const EditAccount(),
        '/createAcc': (context) => const CreateAcc(),
        '/howToUse_1': (context) => HowtoUse_1(),
        '/howToUse_2': (context) => HowtoUse_2(),
        '/howToUse_3': (context) => HowtoUse_3(),
        '/bluetooth': (context) => Bluetooth(),
        //'/history': (context) => const EditAccount(),
        '/login': (context) => const Login(),
        '/profile': (context) => const Profile(),
      },
      initialRoute: '/login',
    );
  }
}


class Profile extends StatelessWidget {
  const Profile({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blind Reader',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Blind Reader", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.red,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                  print('Logout Button Clicked!');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('personalinfor').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<QueryDocumentSnapshot> profiles = snapshot.data?.docs ?? [];

              return ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  var data = profiles[index].data() as Map<String, dynamic>;

                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 130,
                                height: 130,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image(
                                    image: AssetImage("assets/image/blindPerson.jpg"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                data["username"] ?? "N/A",
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text("FullName: ${data["Full name"] ?? "N/A"}"),
                      Text("Username: ${data["username"] ?? "N/A"}"),
                      Text("Age: ${data["Age"] ?? "N/A"}"),
                      Text("Date of birth: ${data["DOB"] ?? "N/A"}"),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/editAcc');
              print('Edit Profile Button Clicked!');
            },
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 193, 193, 193),
              fixedSize: Size(200, 50),
            ),
            child: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/homepage');
          },
          child: Text(
            'Back',
            style: TextStyle(fontSize: 15),
          ),
          backgroundColor: Colors.red,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}


class Homepage extends StatelessWidget {
  const Homepage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blind Reader',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Blind Reader", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.red,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // method--------------------------------------------------------------------------
                  Navigator.pushNamed(
                      context, '/login'); 
                  print('Logout Button Clicked!');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage("assets/image/blindPerson.jpg"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Somchai",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // method--------------------------------------------------------------------------
                Navigator.pushNamed(context, '/history');
                print('History Button Clicked!');
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 193, 193, 193),
                fixedSize: Size(200, 50),
              ),
              child: Text(
                'History',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // method--------------------------------------------------------------------------------
                Navigator.pushNamed(context, '/profile');
                print('Profile Button Clicked!');
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 193, 193, 193),
                fixedSize: Size(200, 50),
              ),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // method--------------------------------------------------------------------------------
                Navigator.pushNamed(context, '/howToUse_1');
                print('How to use Button Clicked!');
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 193, 193, 193),
                fixedSize: Size(200, 50),
              ),
              child: Text(
                'How to use',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // method------------------------------------------------------------------------------------
                  Navigator.pushNamed(context, '/bluetooth');
                  print('Blind Mode Clicked!');
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Blind Mode",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditAccount extends StatelessWidget {
  //final String data = ModalRoute.of(context)!.settings.arguments as String;

  const EditAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Edit account information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Full name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Date of Birth',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // method-----------------------
            Navigator.pop(context);
            print('Save Button Clicked!');
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text('Save', style: TextStyle(color: Colors.white)),
        ),
      ),
    ));
  }
}

//add account database in this part
class CreateAcc extends StatelessWidget {
  const CreateAcc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create account information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Full name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true, // Ensures password input is hidden
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
                keyboardType:
                    TextInputType.emailAddress, // Sets keyboard type to email
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Date of Birth',
                ),
                keyboardType:
                    TextInputType.datetime, // Sets keyboard type to date/time
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Add your button click logic here
                  print('Upload Picture Button Clicked!');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey, // Set the background color to gray
                ),
                child: Text('Upload Picture',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add your register logic here
                      Navigator.pop(context);
                      print('Create Account Clicked!');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      fixedSize: Size(200, 50),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: InkWell(
                      onTap: () {
                        // Add your navigation logic to the sign-in page
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Already have an account? Click to sign in",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your login logic here
                        Navigator.pushNamed(context, '/homepage');
                        print('Login Clicked!');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        fixedSize: Size(200, 50),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Don't have an account yet?",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add your register logic here
                        Navigator.pushNamed(context, '/createAcc');
                        print('Register Clicked!');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 193, 193, 193),
                        fixedSize: Size(200, 50),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bluetooth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/ble.png', width: 298, height: 330),
            SizedBox(height: 30),
            Text(
              'Connection successfully.',
              style: TextStyle(color: Colors.green, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}

class HowtoUse_1 extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> fetchTTS(String text) async {
    final String apiKey = 'AIzaSyA4OMl8Cx4mZhFblEzvvnI6MNrnM7-RnXg'; 
    final String endpoint = 'https://texttospeech.googleapis.com/v1/text:synthesize';

    final Map<String, dynamic> requestBody = {
      'input': {'text': text},
      'voice': {'languageCode': 'en-US', 'name': 'en-US-Wavenet-D'},
      'audioConfig': {'audioEncoding': 'LINEAR16'},
    };

    try {
      final http.Response response = await http.post(
        Uri.parse('$endpoint?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String audioContent = responseData['audioContent'];

        // Save audio content to a temporary file
        File tempFile = File('${Directory.systemTemp.path}/temp_audio.wav');
        await tempFile.writeAsBytes(base64Decode(audioContent));
        print(tempFile.path);
        // Play the audio file
        //await _audioPlayer.play(tempFile.path as Source);
        await _audioPlayer.play(DeviceFileSource(tempFile.path));
      } else {
        // Error handling
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'How to Use',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'How to Use',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '1. Turn on the IoT devices',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  fetchTTS('Turn on the IoT decive');
                  print('Image Button Pressed');
                },
                child: Image.asset(
                  "assets/image/sound.jpg",
                  height: 100.0,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/homepage');
                },
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the next page 
                  Navigator.pushNamed(context, '/howToUse_2');
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class HowtoUse_2 extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> fetchTTS(String text) async {
    final String apiKey = 'AIzaSyA4OMl8Cx4mZhFblEzvvnI6MNrnM7-RnXg'; 
    final String endpoint = 'https://texttospeech.googleapis.com/v1/text:synthesize';

    final Map<String, dynamic> requestBody = {
      'input': {'text': text},
      'voice': {'languageCode': 'en-US', 'name': 'en-US-Wavenet-D'},
      'audioConfig': {'audioEncoding': 'LINEAR16'},
    };

    try {
      final http.Response response = await http.post(
        Uri.parse('$endpoint?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String audioContent = responseData['audioContent'];

        // Save audio content to a temporary file
        File tempFile = File('${Directory.systemTemp.path}/temp_audio.wav');
        await tempFile.writeAsBytes(base64Decode(audioContent));
        print(tempFile.path);
        // Play the audio file
        // await _audioPlayer.play(tempFile.path as Source);
        await _audioPlayer.play(DeviceFileSource(tempFile.path));
      } else {
        // Error handling
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'How to Use',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'How to Use',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '2. Make sure that the mobile phone connect to Internet wifi',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  fetchTTS('Make sure that the mobile phone connect to Internet wifi');
                  print('Image Button Pressed');
                },
                child: Image.asset(
                  "assets/image/sound.jpg",
                  height: 100.0,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/howToUse_1');
                },
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the next page 
                  Navigator.pushNamed(context, '/howToUse_3');
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

class HowtoUse_3 extends StatelessWidget {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> fetchTTS(String text) async {
    final String apiKey = 'AIzaSyA4OMl8Cx4mZhFblEzvvnI6MNrnM7-RnXg'; 
    final String endpoint = 'https://texttospeech.googleapis.com/v1/text:synthesize';

    final Map<String, dynamic> requestBody = {
      'input': {'text': text},
      'voice': {'languageCode': 'en-US', 'name': 'en-US-Wavenet-D'},
      'audioConfig': {'audioEncoding': 'LINEAR16'},
    };

    try {
      final http.Response response = await http.post(
        Uri.parse('$endpoint?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String audioContent = responseData['audioContent'];

        // Save audio content to a temporary file
        File tempFile = File('${Directory.systemTemp.path}/temp_audio.wav');
        await tempFile.writeAsBytes(base64Decode(audioContent));
        print(tempFile.path);
        // Play the audio file
        //await _audioPlayer.play(tempFile.path as Source);
        await _audioPlayer.play(DeviceFileSource(tempFile.path));
      } else {
        // Error handling
        print('Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'How to Use',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'How to Use',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '3. Turn on the blutooth connection of your mobile phone',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  fetchTTS('Turn on the blutooth connection of your mobile phone');
                  print('Image Button Pressed');
                },
                child: Image.asset(
                  "assets/image/sound.jpg",
                  height: 100.0,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/howToUse_2');
                },
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the next page 
                  Navigator.pushNamed(context, '/homepage');
                },
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 15),
                ),
                backgroundColor: Color.fromARGB(255, 29, 206, 53),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
