# 🚴‍♂️ Bike Shop App

A modern, responsive Flutter application for a bike shop featuring a beautiful UI with custom animations, smooth scrolling, and professional design patterns.

## 📱 Demo

[![Bike Shop App Demo](https://img.shields.io/badge/YouTube-Demo%20Video-red?style=for-the-badge&logo=youtube)](https://youtube.com/watch?v=YOUR_VIDEO_ID)

> **Watch the full demo on YouTube** - See the app in action with all its features and animations!

## ✨ Features

- **🎨 Modern UI Design**: Dark theme with gradient backgrounds and custom clippers
- **🔄 Smooth Animations**: Rotated widgets, animated navigation, and scroll-based interactions
- **📱 Responsive Layout**: Adapts perfectly to all screen sizes and orientations
- **🎯 Custom Navigation**: Elevated bottom navigation bar with rotation effects
- **🔍 Search Functionality**: Integrated search with gradient buttons
- **💝 Favorites System**: Heart icons for saving favorite bikes and accessories
- **📊 Category Filtering**: Dynamic category selection with BLoC state management
- **🎭 Custom Clippers**: Unique background shapes and navigation bar designs

## 🛠️ Technical Implementation

### **Packages & Dependencies**

This app is built using the following key packages from `pubspec.yaml`:

- **`flutter_svg`** - SVG icons and graphics throughout the UI
- **`flutter_screenutil`** - Responsive design across all device sizes
- **`flutter_bloc`** - State management for navigation and category selection
- **`get_it`** - Dependency injection and service locator pattern
- **`equatable`** - Value equality for BLoC states

### **Custom Clippers**

#### **Background Clipper (`DiagonalGradientBackground`)**
- **Location**: `lib/core/clippers/home_clipper.dart`
- **Usage**: Creates diagonal gradient background with custom cut shapes
- **Implementation**: Uses `CustomClipper<Path>` to create diagonal cuts and layered gradients

#### **Bottom Navigation Clipper (`TaperedBottomClipper`)**
- **Location**: `lib/core/clippers/tapered_bottom_clipper.dart`
- **Usage**: Shapes the bottom navigation bar with tapered edges
- **Effect**: Creates a subtle curve where the left side is lower than the right side

### **Widget Rotations**

#### **Bike Cover Widget**
- **Location**: `lib/core/widgets/bike_cover_widget.dart`
- **Rotation**: `-0.09` radians for a subtle tilted appearance
- **Effect**: Adds visual interest to the main promotional banner

#### **Product Cards**
- **Location**: `lib/core/widgets/grid_products.dart`
- **Rotation**: `-0.09` radians for consistent tilted design
- **Effect**: Creates a dynamic, modern product grid layout

#### **Category Row**
- **Location**: `lib/core/widgets/category_row.dart`
- **Rotation**: `-0.09` radians for filter buttons
- **Effect**: Maintains design consistency across all UI elements

#### **Bottom Navigation**
- **Location**: `lib/core/widgets/flexible_bottom_nav_bar.dart`
- **Rotation**: `-0.15` radians for selected items
- **Effect**: Selected navigation items have subtle rotation for visual emphasis

### **BLoC Implementation**

#### **Bottom Navigation BLoC**
- **Location**: `lib/view/blocs/bottom_nav_bloc/`
- **Purpose**: Manages current navigation index and tab switching
- **Usage**: Controls which navigation item is selected and active

#### **Category Selection BLoC**
- **Location**: `lib/view/blocs/select_category_bloc/`
- **Purpose**: Manages category filtering state
- **Usage**: Handles "All" vs specific category selection for product filtering

#### **BLoC Selector Usage**
```dart
// Example from CategoryRow widget
BlocSelector<SelectCategoryBloc, int, bool>(
  selector: (state) => state == 0,
  builder: (context, isSelected) {
    return GradientButton(
      // Button implementation based on selection state
    );
  },
)
```

### **State Management Patterns**

- **Event-Driven Architecture**: Clear separation of events, states, and business logic
- **Selective Rebuilding**: Using `BlocSelector` for efficient UI updates
- **Dependency Injection**: Service locator pattern for clean architecture
- **State Persistence**: Navigation state maintained across app lifecycle

## 🎨 UI Components

### **Custom Widgets**
- **`GradientButton`** - Reusable buttons with gradient backgrounds
- **`BikeCoverWidget`** - Promotional banner with bike imagery
- **`CategoryRow`** - Horizontal category filter buttons
- **`GridProducts`** - Responsive product grid layout
- **`FlexibleBottomNavBar`** - Custom navigation with animations

### **Theme System**
- **Location**: `lib/core/theme/light_theme.dart`
- **Primary Font**: Poppins font family with multiple weights
- **Color Scheme**: Dark theme with blue gradients and white text
- **Responsive Design**: Screen-util based sizing and spacing

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK (3.6.0 or higher)
- Dart SDK (3.6.0 or higher)
- Android Studio / VS Code

### **Installation**
```bash
# Clone the repository
git clone https://github.com/yourusername/bike_task.git

# Navigate to project directory
cd bike_task

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### **Build for Production**
```bash
# Android APK
flutter build apk --release

# iOS (requires macOS)
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── bloc/           # Base BLoC classes
│   ├── clippers/       # Custom shape clippers
│   ├── extensions/     # Context extensions
│   ├── service_locator/ # Dependency injection
│   ├── theme/          # App theme and styling
│   └── widgets/        # Reusable UI components
├── view/
│   ├── blocs/          # Feature-specific BLoCs
│   └── task_view.dart  # Main app screen
└── main.dart           # App entry point
```

## 🔧 Key Features Implementation

### **Responsive Design**
- Uses `flutter_screenutil` for consistent sizing across devices
- Percentage-based layouts for universal compatibility
- Adaptive spacing and sizing based on screen dimensions

### **Animation System**
- Smooth transitions between navigation states
- Scroll-based navigation bar hiding/showing
- Rotation animations for selected items
- Scale and slide animations for UI elements

### **Performance Optimizations**
- Efficient BLoC selectors for minimal rebuilds
- Custom clippers for optimized rendering
- Responsive image loading and caching
- Smooth scrolling with iOS-optimized physics

## 🎯 Future Enhancements

- [ ] User authentication and profiles
- [ ] Shopping cart functionality
- [ ] Payment integration
- [ ] Push notifications
- [ ] Offline mode support
- [ ] Multi-language support

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Ali Mazen**
- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Ali Mazen](https://linkedin.com/in/yourprofile)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC pattern creators for state management
- Poppins font designers for beautiful typography
- Open source community for inspiration and support

---

⭐ **Star this repository if you found it helpful!**

🔗 **Watch the demo video**: [YouTube Demo](https://youtube.com/watch?v=YOUR_VIDEO_ID)
