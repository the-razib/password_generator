# Password Generator

## Description
Password Generator is a Flutter application that generates secure passwords based on user-defined criteria. The app allows users to specify the length of the password and whether to exclude numbers or special characters.

## Features
- Generate secure passwords
- Specify password length
- Option to exclude numbers
- Option to exclude special characters
- Copy generated password to clipboard
- Neumorphic design for UI elements
  
## API Usage
This project uses an external API to enhance its functionality. The API is used to fetch additional data required for generating secure passwords.

## UI
<img src="https://github.com/user-attachments/assets/fb59e609-4c8d-4d77-b19b-db2023103d57" alt="password_generator_ui" width="300"/>


## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/md-razib11/password_generator.git
   ```
2. Navigate to the project directory:
   ```sh
   cd password_generator
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```

## Usage
1. Create a `.env` file in the root directory and add your API key:
   ```env
   API_KEY=your_api_key_here
   ```
2. Run the application:
   ```sh
   flutter run
   ```

## Dependencies
- Flutter
- http: ^1.2.2
- flutter_dotenv: ^5.2.1
- google_fonts: ^6.2.1

## Development
To contribute to this project, follow these steps:
1. Fork the repository.
2. Create a new branch:
   ```sh
   git checkout -b feature/your-feature-name
   ```
3. Make your changes and commit them:
   ```sh
   git commit -m "Add your feature"
   ```
4. Push to the branch:
   ```sh
   git push origin feature/your-feature-name
   ```
5. Create a pull request.

## License
This project is licensed under the MIT License. See the `LICENSE` file for more details.
