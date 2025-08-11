# Face Detection App

A comprehensive Flutter application that provides real-time face detection with emotion recognition, live camera feed, and image capture capabilities using Google ML Kit.

## Features

### 🎯 Live Face Detection
- **Real-time detection**: Continuously monitors camera feed for faces
- **High accuracy**: Uses Google ML Kit's accurate face detection mode
- **Visual feedback**: Green border around detected faces with confidence percentage
- **Face landmarks**: Displays facial landmarks for precise detection

### 😊 Emotion Recognition
- **Smile detection**: Analyzes smiling probability (Happy/Smiling, Neutral, Sad)
- **Eye state**: Detects if eyes are open or closed
- **Head direction**: Identifies head rotation (left, right, tilted)
- **Live status**: Shows current emotion and face orientation in real-time

### 📸 Image Capture & Analysis
- **Capture photos**: Take high-quality images with face detection overlay
- **Gallery integration**: Select and analyze images from device gallery
- **Save functionality**: Save captured images with detection results
- **Analysis dialog**: View detailed face detection results for captured images

### 🎮 User Interface
- **Modern design**: Clean, intuitive Material Design 3 interface
- **Status indicators**: Real-time detection status and confidence levels
- **Progress bars**: Visual representation of face detection confidence
- **Multiple controls**: Camera capture, gallery picker, and camera toggle buttons

## Technical Features

### 🔧 Face Detection Configuration
```dart
FaceDetector(
  options: FaceDetectorOptions(
    performanceMode: FaceDetectorMode.accurate,
    landmarkMode: FaceDetectorLandmarkMode.all,
    classificationMode: FaceDetectorClassificationMode.all,
    minFaceSize: 0.15,
    enableTracking: true,
  ),
)
```

### 📱 Permissions
- **Camera access**: Required for live face detection
- **Storage access**: For saving captured images and accessing gallery
- **Internet access**: For ML Kit face detection models

### 🎨 UI Components
- **Status panel**: Shows detection status, emotion, and confidence
- **Camera preview**: Live camera feed with face detection overlay
- **Control buttons**: Capture, gallery, and camera toggle
- **Dialogs**: Image analysis and capture result dialogs

## Emotion Analysis

The app analyzes multiple facial features to determine emotions:

### 😊 Smile Detection
- **Happy/Smiling**: Smile probability > 70%
- **Neutral**: Smile probability 30-70%
- **Sad**: Smile probability < 30%

### 👀 Eye State
- **Eyes open**: Both eyes open probability > 30%
- **Eyes closed**: Both eyes open probability < 30%

### 🎯 Head Direction
- **Looking left**: Head rotation < -15 degrees
- **Looking right**: Head rotation > 15 degrees
- **Head tilted**: Z-axis rotation > 15 degrees

## Usage Instructions

### 1. Initial Setup
1. Launch the app
2. Grant camera permission when prompted
3. Wait for camera initialization

### 2. Live Detection
- Point camera at faces
- Watch real-time detection status
- Observe emotion analysis
- Monitor confidence percentage

### 3. Image Capture
- Tap the blue camera button to capture
- View captured image with analysis
- Save image to gallery if desired

### 4. Gallery Analysis
- Tap the green gallery button
- Select an image from your device
- View face detection results

### 5. Camera Toggle
- Tap the orange flip camera button
- Switch between front and back cameras

## Dependencies

```yaml
dependencies:
  google_mlkit_face_detection: ^0.10.0
  camera: ^0.10.5+9
  permission_handler: ^11.3.1
  image_picker: ^1.0.7
  path_provider: ^2.1.2
  image: ^4.1.7
  flutter_svg: ^2.0.9
  lottie: ^3.0.0
```

## Platform Support

### Android
- Minimum SDK: API 21 (Android 5.0)
- Camera permissions configured
- Storage permissions enabled

### iOS
- Minimum iOS version: 12.0
- Camera usage descriptions added
- Photo library permissions configured

## Performance Features

- **Optimized processing**: Efficient image stream processing
- **Memory management**: Proper disposal of camera resources
- **Lifecycle handling**: Automatic camera management on app state changes
- **Error handling**: Graceful handling of detection errors

## Face Detection Accuracy

The app achieves high accuracy through:
- **Accurate mode**: Uses precise detection algorithms
- **Landmark tracking**: Monitors facial landmarks
- **Classification**: Analyzes facial features
- **Tracking**: Maintains face tracking across frames

## Future Enhancements

- Multiple face detection
- Advanced emotion recognition
- Face recognition (identity)
- Age and gender detection
- Real-time filters and effects
- Export detection data
- Batch image processing

## Troubleshooting

### Camera Not Working
1. Check camera permissions
2. Restart the app
3. Ensure camera is not used by other apps

### Detection Issues
1. Ensure good lighting
2. Face should be clearly visible
3. Maintain appropriate distance from camera

### Performance Issues
1. Close other camera apps
2. Restart device if needed
3. Check available memory

## License

This project is created for educational and demonstration purposes.
# facedetectedapp
