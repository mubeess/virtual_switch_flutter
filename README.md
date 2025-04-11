# Virtual Switch

A Flutter application that interfaces with the JSONPlaceholder API to fetch and display posts. The app features client-side search functionality and detailed post views.

## Features

1. **Post Listing:**

   - Fetches and displays a list of posts from the JSONPlaceholder API
   - Each post shows the title, author information, and a preview of the content
   - Clean, modern card-based UI

2. **Search Functionality:**

   - Built-in search bar allows filtering posts based on title, body, user ID, or post ID
   - Results update in real-time as you type
   - Shows result count and provides easy reset option

3. **Detail View:**
   - Tap on any post to view more detailed information
   - Detail view shows the complete post content, user information, and comments
   - Interactive elements with feedback via snackbars

## Project Structure

The application follows a component-based architecture:

- **Models**: Data classes for Posts and Comments
- **Services**: API service for fetching data
- **Screens**: Main UI containers
- **Widgets**: Reusable UI components

## Getting Started

### Prerequisites

Make sure you have Flutter installed on your machine. For help getting started with Flutter, view the [online documentation](https://docs.flutter.dev/).

### Installation

1. Clone the repository

   ```
   git clone https://github.com/yourusername/virtual_switch.git
   ```

2. Navigate to the project directory

   ```
   cd virtual_switch
   ```

3. Get dependencies

   ```
   flutter pub get
   ```

4. Run the app
   ```
   flutter run
   ```

## Development Notes

- The application uses the JSONPlaceholder API for demo data
- All search functionality is performed client-side for better performance
- The UI is designed with Material 3 principles

## Additional Resources

For help getting started with Flutter development:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter online documentation](https://docs.flutter.dev/)
