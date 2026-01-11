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


<table>
  <tr>
    <td align="center"><b>Add Habit</b></td>
    <td align="center"><b>Home Screen</b></td>
    <td align="center"><b>Profile screen</b></td>
    <td align="center"><b>Notification</b></td>
  </tr>
  <tr>
    <td>
      <video src="https://github.com/user-attachments/assets/254b6afb-2480-4522-8d50-7296148e3a9f" width="100%" controls></video>
    </td>
    <td>
      <video src="https://github.com/user-attachments/assets/3ee32457-22c3-4c51-9992-b53222fc4d2a" width="100%" controls></video>
    </td>
    <td>
      <video src="https://github.com/user-attachments/assets/dec16830-b906-4f40-800f-e3d124f9c95e" width="100%" controls></video>
    </td>
    <td>
      <img alt="Screenshot 2026-01-11 at 7 11 09 PM" src="https://github.com/user-attachments/assets/e4a0c1c2-70d2-4663-acae-67f1d738cddf" />
    </td>
  </tr>
</table>



