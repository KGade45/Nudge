## 🧭 Nudge
#### Nudge is a smart reminder app that helps you build habits using time and location context.
#### Instead of sending reminders that are easy to ignore, Nudge tries to notify you only when it actually makes sense.

### ✨ What makes Nudge different?
- ⏰ Time-based reminders (with minute-level precision)
- 📍 Location-aware nudges using geofencing
- 🔄 Reverse geofencing
  - If it’s time but you’re not at the location, Nudge tells you where to go
- 🏠 Saved places like Home and Office
- 🔔 Custom notification sounds
- 🔁 Repeat rules (Everyday / Weekdays / Weekends)
- ✅ Daily completion tracking

### 📱 App Flow
- Home – Today’s habits with time, status, and completion
- Add Habit – Configure time, location, sound, and repeat
- Profile – Routine times, saved locations, and permissions
- Progress (in progress) – Weekly & monthly summaries


### 🧠 How it works
- Core Data for persistence
- UNUserNotificationCenter for reminders
- Core Location + Geofencing for location-based triggers
- UIKit (with some SwiftUI where it makes sense)


### 🔐 Permissions
- Notifications – for reminders
- Location (Always) – for geofencing
- Permissions are requested only when required.

### 🛠 Tech Stack
- Swift
- UIKit
- Core Data
- Core Location
- User Notifications
- MapKit

### 🚧 Status
- This is an actively evolving personal project.
- The core logic is stable, while UI polish and analytics are ongoing.

### 👋 Closing
- Nudge is about gentle reminders, not interruptions.
  - Small nudges.
  - Right time.
  - Right place.
