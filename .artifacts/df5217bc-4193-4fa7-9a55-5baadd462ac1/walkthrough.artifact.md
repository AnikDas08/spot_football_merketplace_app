# Auth UI & Background Refinement Walkthrough

I have updated the authentication screens to have a true full-screen background and improved the visibility of all UI elements.

## Changes Made

### 1. Full-Screen Background for Auth
- Added `auth_bg.png` to **Sign In** and **Sign Up** screens.
- Enabled `extendBody` and `extendBodyBehindAppBar` to ensure the image covers the entire screen, including the status bar and bottom area.
- Made the `SignupAppbar` background transparent so the image shows through.

### 2. Improved Element Visibility
- **TextFields**: Added a subtle, semi-transparent white fill (`Colors.white.withOpacity(0.1)`) to all input fields on auth screens. This makes them stand out beautifully against the dark background.
- **Text Colors**: Set input text, labels, and titles to white for clear readability.
- **Account Links**: Updated "Don't have an account?" and "Already have an account?" text to a light gray and changed the "Sign Up" / "Login" links to **Yellow (Gold)** for high visibility.

### 3. Onboarding Typography Revert
As requested, I have reverted the following elements on the **Onboarding Screen** to use the **Montserrat** font family instead of the Serif font:
- "Play The Game" header.
- "Welcome To" text.
- "Sign Up" and "Sign In" button labels.

## Verification Results

- [x] Sign In and Sign Up backgrounds now fill the entire screen perfectly.
- [x] Input fields are clearly defined with their new fill color.
- [x] All text on the dark background is easily readable.
- [x] Onboarding screen matches the previous font style for brand consistency.

render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/auth/sign%20in/presentation/screen/sign_in_screen.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/auth/sign%20up/presentation/screen/sign_up_screen.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/onboarding_screen/onboarding_screen.dart)
