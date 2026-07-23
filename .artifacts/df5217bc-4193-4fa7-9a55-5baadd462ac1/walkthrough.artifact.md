# Universal Typography & Branding Overhaul Walkthrough

I have performed a comprehensive update of the app's visual identity, focusing on Title Case standardization, Serif font application, and project-wide font weight normalization.

## Changes Made

### 1. Title Case Standardization
- Updated almost all constants in `AppString` to follow **Title Case** (e.g., "Upcoming Fixtures", "Recent Results", "Match Summary").
- This ensures that headings across the entire app are consistent and professional.

### 2. Modern Serif (Playfair Display) for Big Text
- **Centralized Logic**: Updated the `CommonText` component to automatically apply **Playfair Display** if the `fontSize` is 18 or higher.
- **Action Buttons**: Updated `CommonButton` to use Playfair Display for its label by default, ensuring prominent actions (Sign In, Sign Up, etc.) stand out.
- **Manual Overrides**: Explicitly applied the Serif font to key headers on the Onboarding, Sign In, and Sign Up screens to ensure the brand identity is strong from the first interaction.

### 3. Project-wide Font Weight Normalization (No Bold)
- **Automatic Handling**: Modified `CommonText` to catch any bold weights (`bold`, `w600`, `w700`, etc.) and automatically downgrade them to **`w500`** (Medium). This prevents text from looking too dark or heavy.
- **Manual Cleanup**: Audited and updated explicit `TextStyle` and `CommonText` weight declarations in major screens (Referee Dashboard, Match Info, Subscription, etc.) to ensure a clean, "Normal" look.

### 4. Navigation & Page Titles
- Updated the `NavBarController` and all App Bar titles to follow Title Case (e.g., "Eng TV", "Player Comparison").

## Verification Results

- [x] **Header Check**: All major section headers (Latest News, Upcoming Events, etc.) are Title Case and use the Serif font.
- [x] **Action Check**: Login, Sign Up, and role cards are Title Case and use the Serif font.
- [x] **Weight Check**: Scanned the app for excessively bold text; all headings and labels now feel visually balanced at `w500`.
- [x] **Consistency**: The Serif font and Title Case are applied uniformly across Home, Auth, Profile, and Stats flows.

render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/utils/constants/app_string.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/component/text/common_text.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/component/button/common_button.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/onboarding_screen/onboarding_screen.dart)
