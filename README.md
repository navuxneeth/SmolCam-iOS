# SmolCam-iOS

The iOS version of [SmolCam](https://github.com/navuxneeth/SmolCam), a concept camera application that simulates manual camera controls in a clean, intuitive way. It's designed for those who appreciate the aesthetics of photography and enjoy having retro-style tactile control over their image settings :)

**This project is a work in progress.** It will be updated again by **September 30th, 2025**, with full features.

## Screenshots

<img width="6764" height="2400" alt="image" src="https://github.com/user-attachments/assets/8ac0f054-e322-415a-ac5f-030f58588349" />


## Features

-   **Two Control Modes**: Seamlessly switch between Manual Mode and Filter Mode.
-   **Live Creative Filters**:
    -   **Saturation Slider**: Adjust the color intensity of your image in real-time.
    -   **Grain Overlay**: Add an atmospheric, film-like grain effect with adjustable intensity.
-   **Built-in Gallery**: View your captured moments in a beautiful, staggered grid gallery.
-   **Full-Screen Image Viewer**: Tap on any photo in the gallery to view it in a full-screen, zoomable interface.
-   **Elegant UI**: A clean, minimalist design with smooth animations and transitions.
-   **Manual Camera Controls (Planned)**: Adjust settings for the exposure triangle with interactive sliders:
    -   Aperture (F-stop)
    -   Shutter Speed (S)
    -   Exposure Value (EV)
    -   ISO

## How to Build

This is a standard Xcode project.

1.  Clone the repository.
2.  Open the `SmolCam.xcodeproj` file in Xcode.
3.  Select a target simulator or a connected iOS device.
4.  Build and run the application.

## Code Explanation

### 1. High-Level Project Overview

SmolCam-iOS is a mobile application for iOS that simulates a camera interface with manual controls and image filters. It's designed to provide a tactile, retro-inspired user experience. The application has three main screens:

-   **Main Camera Screen (ViewController)**: The primary interface where users can adjust camera settings, apply filters, and pretend to take pictures.
-   **Gallery Screen (GalleryViewController)**: A screen that displays a collection of pre-defined images in a staggered grid.
-   **Image Viewer Screen (ImageViewerController)**: A fullscreen viewer to see gallery images up close, with pinch-to-zoom functionality.

The project is built using **Swift**, the modern, recommended language for iOS development. A key aspect of this project is its heavy reliance on **Xcode's Storyboards** for laying out the user interface. This visual approach is a departure from the Android version's XML-based layouts. Much of the UI is designed by dragging, dropping, and connecting elements visually. Consequently, the Swift code is less about programmatically creating UI from scratch and more focused on defining the logic for the drag-and-drop interactions, handling UI events, and managing the flow between different views.

### 2. Project Structure and Configuration Files

````
.
├── SmolCam
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   ├── Base.lproj
│   │   ├── LaunchScreen.storyboard
│   │   └── Main.storyboard
│   ├── Camera.storyboard
│   ├── Gallery.storyboard
│   ├── GalleryImageCell.swift
│   ├── GalleryViewController.swift
│   ├── ImageViewerController.swift
│   ├── Info.plist
│   ├── SceneDelegate.swift
│   └── ViewController.swift
├── SmolCam.xcodeproj
│   ├── project.pbxproj
│   └── project.xcworkspace
│       └── contents.xcworkspacedata
└── README.md
````

-   **`SmolCam.xcodeproj`**
    This is the main project file for Xcode. It contains all the settings for the build process, manages the file structure, and links all the necessary frameworks and dependencies.

-   **`Info.plist`**
    This file is the application's property list, which is a core configuration file for iOS apps. It contains metadata about the app, such as its bundle identifier, version number, and the permissions it requires (like camera access).

-   **`Assets.xcassets`**
    This is the asset catalog, which is Xcode's way of managing all the visual assets for the project. This includes app icons, images, colors, and other resources. It helps in organizing assets and providing the correct resolution for different devices.

### 3. The App Module: Core of the Application

This is the main module containing all the application's code and resources.

-   **`AppDelegate.swift`**
    This file contains the `AppDelegate` class, which is the entry point of the application and is responsible for handling app-level events, such as launching and termination.

-   **`SceneDelegate.swift`**
    For apps that support multiple windows or scenes, this file manages the lifecycle of a scene, which is an instance of the app's UI.

### 4. The User Interface: Storyboards and Resources

The entire visual aspect of SmolCam is defined using Storyboards and the asset catalog.

-   **Storyboard Files (`Base.lproj/Main.storyboard`, `Camera.storyboard`, `Gallery.storyboard`)**
    These files are the visual blueprint of the app's user interface. Unlike the XML layouts in Android Studio, Storyboards in Xcode allow for a more graphical approach to UI design. The main screens of the app, including the camera view, gallery, and image viewer, are laid out in these files. The transitions between these screens (segues) are also defined visually within the Storyboard.

-   **Asset Catalog (`Assets.xcassets`)**
    This directory contains all visual assets, including vector drawables for icons (in SVG or PDF format), custom colors, and bitmap images (PNG/JPG) for camera backgrounds and overlays. This centralized approach makes managing resources much more efficient.

### 5. Application Logic: The Swift Code

This is where the app's behavior is implemented.

-   **`ViewController.swift`**
    This is the most complex class, orchestrating the main camera screen. It manages the UI state by connecting to the UI elements defined in the Storyboard via `@IBOutlet`s. It also contains the `@IBAction` functions that define what happens when a user interacts with a button or a slider. It handles the logic for both filter sliders (saturation, grain) and manual controls (Aperture, Shutter Speed, etc.) and implements the shutter animation effect.
-   **`GalleryViewController.swift`**
    This class manages the Gallery screen, displaying a grid of images.
-   **`ImageViewerController.swift`**
    This class handles the full-screen image viewing with zoom functionality.
-   **`GalleryImageCell.swift`**
    This defines the custom cell used in the gallery's collection view.

## Credits

-   **Built by Navaneeth Sankar K P** ([LinkedIn](https://www.linkedin.com/in/navaneeth-sankar-k-p)).
-   **Design Inspiration**: The user interface and overall aesthetic are inspired (initial brainstorming) by the beautiful design work of Hristo Hristov ([LinkedIn](https://www.linkedin.com/in/hristo-hristov-2bb0341a8)).
-   **Professor**: A special thanks to my professor, **Chesta Malkani** ([LinkedIn](https://www.linkedin.com/in/chesta-malkani-25a550137)), for everything she taught, which made this project possible.
