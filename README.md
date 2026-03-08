# 📚 Studdy Buddy

A Flutter app built by students, for students. Studdy Buddy helps you stay on top of your academic life — track deadlines, calculate your GPA, manage study materials, and keep your timetables all in one place.

> 🚧 **Work in Progress** — actively being developed by a two-person team.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🗓️ **Deadline Tracker** | Add and manage assignment/exam deadlines with subject tagging, stored locally using Hive |
| 🧮 **GPA Calculator** | Enter subject names, credit hours, and grades (O/A+/A/B+/B/C/F) to instantly calculate your semester GPA |
| 📂 **Semester Materials** | Organise and store PDFs by subject — upload, view, and delete study files |
| 📅 **Timetable Viewer** | Upload and view your class timetable PDFs with swipe-to-delete support |
| 🌙 **Dark / Light Mode** | Full theme switching with persistent preference |
| 🚀 **Onboarding Flow** | First-time user onboarding screen |
| 👤 **Profile Screen** | Personal profile section |

---

## 🛠️ Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** Provider
- **Local Storage:** Hive + SharedPreferences
- **File Handling:** file_picker, path_provider, open_file
- **PDF Viewing:** Built-in PDF viewer dialog

---

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point, Hive init, Provider setup
├── theme.dart                   # Light & dark theme definitions
├── theme_provider.dart          # Theme state management
├── auth/
│   ├── login_screen.dart
│   └── signup_screen.dart
├── onboarding/
│   └── onboarding.dart
├── home_screen/
│   ├── home_screen.dart         # Bottom nav + AppBar
│   ├── homecreen_scaffhold.dart # Main home content
│   ├── profile_screen.dart
│   └── settingscreen.dart
├── deadline_tracker/
│   ├── deadline_model.dart      # Deadline data model
│   ├── deadline_provider.dart   # Deadline state management
│   ├── deadline_list.dart       # View deadlines
│   └── add_deadline.dart        # Add new deadline
├── gpa_calculator/
│   └── gpa_screen.dart          # GPA calculator UI + logic
├── material_screen/
│   └── material_screen.dart     # Subject-wise PDF manager
├── Time_table_viewer/
│   ├── models/timetable_documet.dart
│   ├── screen/timetable_list_screen.dart
│   └── widgets/pdf_viewer_dialog.dart
└── widgets/
    └── onboardig_card.dart
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart SDK
- Android Studio or VS Code with Flutter extension

### Installation

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/studdy_buddy.git
cd studdy_buddy

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 👥 Team

| Name | Role | Tools |
|---|---|---|
| [Your Name] | Developer | VS Code · Windows |
| [Friend's Name] | Developer | Android Studio · macOS |

---

## 📌 Roadmap

- [ ] Firebase authentication (login/signup)
- [ ] Push notifications for upcoming deadlines
- [ ] Cloud sync for materials
- [ ] Cumulative GPA (CGPA) calculator
- [ ] Attendance tracker

---

## 📄 License

This project is for educational purposes. Feel free to fork and build on it.