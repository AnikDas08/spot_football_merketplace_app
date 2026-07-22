# Implementation Plan - Navigation & Menu Changes (Point 2)

Refactor navigation titles, menu ordering, and button styles based on client feedback.

## User Review Required

> [!IMPORTANT]
> The menu in the drawer will be restructured to prioritize the requested items (Fixtures, Tables, etc.) for all users, including guests and registered users.

## Proposed Changes

### [Constants & Metadata]

#### [MODIFY] [app_string.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/utils/constants/app_string.dart)
- Change `community` from `"PLAY THE GAME"` to `"Home"`.
- Change `latestNews` from `"latest News"` to `"Home"`.

### [Navigation & Menu]

#### [MODIFY] [navbar_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/navbar/controller/navbar_controller.dart)
- Update `labels` to ensure consistency (already seems to have 'Home').
- Update `titles` to reflect "Home" for the first index.

#### [MODIFY] [app_drawer.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/drawer/presentation/screen/app_drawer.dart)
- **Reorder Menu Items**:
    1.  Fixtures (Link to NavBar index 1)
    2.  League Tables (Link to NavBar index 2)
    3.  ENG TV (Link to NavBar index 3)
    4.  Upcoming Events (Link to external URL)
    5.  Book a Scout (Link to external URL)
    6.  Stats (Link to NavBar index 4)
    7.  Privacy Policy
    8.  Terms of Service
- **UI Tweaks**:
    - "Guest User" text: Set `FontWeight.w400` and reduce `fontSize`.
    - "Login / Sign Up" button: Reduce `height` and `padding`.

### [Onboarding & Auth UI]

#### [MODIFY] [onboarding_screen.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/onboarding_screen/onboarding_screen.dart)
- Reduce size/height of "Sign Up" and "Sign in" buttons.
- Reduce `fontSize` of "Continue with Limited Access".

## Verification Plan

### Manual Verification
- **Titles**: Open the app and verify the top app bar says "Home" instead of "PLAY THE GAME".
- **Home Screen**: Scroll down to the news section and verify the title is "Home" instead of "LATEST NEWS".
- **Drawer**: Open the drawer and verify the menu items are in the correct order.
- **Drawer Profile**: Verify "Guest User" text is smaller and not bold.
- **Buttons**: Check the Login/Sign-Up button in the drawer and the buttons on the Onboarding screen to ensure they appear smaller.
