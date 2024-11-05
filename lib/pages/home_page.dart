import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:password_generator/utils/show_snackBar_message.dart';
import 'package:password_generator/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _generatorPasswordInProgress = false;
  String? password;
  double _passwordLength = 8;
  bool _excludeNumbers = false;
  bool _excludeSpecialChars = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD6EFD8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            const SizedBox(height: 120),
            _buildPasswordDisplay(),
            const SizedBox(height: 30),
            _buildPasswordLengthSlider(),
            _buildExcludeOptions(),
            const SizedBox(height: 25),
            _buildGenerateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Password Generator',
      style: GoogleFonts.delius(textStyle: const TextStyle(fontSize: 40)),
    );
  }

  Widget _buildPasswordDisplay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _PasswordContainer(text: password ?? 'Password'),
          _CopyButton(onCopy: () {
            if (password != null) {
              Clipboard.setData(ClipboardData(text: password!));
              showSnackbarMessage(context, 'Password copied to clipboard');
            }
          }),
        ],
      ),
    );
  }

  Widget _buildPasswordLengthSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          CustomText(title: 'Password length: ${_passwordLength.toInt()}'),
          Slider(
            activeColor: const Color(0xff80AF81),
            value: _passwordLength,
            min: 4,
            max: 32,
            divisions: 28,
            label: _passwordLength.round().toString(),
            onChanged: (double value) {
              setState(() => _passwordLength = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExcludeOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          CheckboxListTile(
            title: const CustomText(title: 'Exclude Numbers'),
            value: _excludeNumbers,

            onChanged: (bool? value) {
              setState(() => _excludeNumbers = value ?? false);
            },
          ),
          CheckboxListTile(
            title: const CustomText(title: 'Exclude Special Characters'),
            value: _excludeSpecialChars,
            onChanged: (bool? value) {
              setState(() => _excludeSpecialChars = value ?? false);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateButton() {
    return _NeumorphicButton(
      onPressed: _passwordGenerator,
      child: Visibility(
        visible: !_generatorPasswordInProgress,
        replacement: const CircularProgressIndicator(),
        child: Text(
          'Generate Password',
          style: GoogleFonts.delius(
            textStyle: const TextStyle(
              color: Color(0xff1A5319),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _passwordGenerator() async {
    setState(() => _generatorPasswordInProgress = true);

    try {
      final queryParams = {
        'length': _passwordLength.toInt().toString(),
        if (_excludeNumbers) 'exclude_numbers': 'true',
        if (_excludeSpecialChars) 'exclude_special_chars': 'true',
      };
      final uri =
          Uri.https('api.api-ninjas.com', '/v1/passwordgenerator', queryParams);

      final response = await get(uri, headers: {
        'Content-Type': 'application/json',
        'X-Api-Key': dotenv.env['API_KEY']!,
      });

      if (response.statusCode == 200) {
        final jsonCode = jsonDecode(response.body);
        setState(() => password = jsonCode['random_password']);
      } else {
        showSnackbarMessage(context, 'Something went wrong');
      }
    } catch (e) {
      showSnackbarMessage(context, 'Failed to generate password');
    } finally {
      setState(() => _generatorPasswordInProgress = false);
    }
  }
}

class _PasswordContainer extends StatelessWidget {
  final String text;

  const _PasswordContainer({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      height: 100,
      width: 280,
      decoration: _neumorphicDecoration,
      child: Text(
        text,
        style: GoogleFonts.delius(
          textStyle: const TextStyle(
            color: Color(0xff1A5319),
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final VoidCallback onCopy;

  const _CopyButton({required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: 60,
      decoration: _neumorphicDecoration,
      child: IconButton(
        icon: const Icon(Icons.copy, size: 44, color: Colors.grey),
        onPressed: onCopy,
      ),
    );
  }
}

class _NeumorphicButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const _NeumorphicButton({required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      height: 50,
      width: 290,
      decoration: _neumorphicDecoration,
      child: TextButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

const _neumorphicDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(25)),
  color: Color(0xffD6EFD8),
  boxShadow: [
    BoxShadow(
      color: Color(0xff80AF81),
      blurRadius: 10,
      spreadRadius: 4,
      offset: Offset(4, 4),
    ),
    BoxShadow(
      color: Colors.white,
      blurRadius: 10,
      spreadRadius: 4,
      offset: Offset(-3, -3),
    ),
  ],
);
