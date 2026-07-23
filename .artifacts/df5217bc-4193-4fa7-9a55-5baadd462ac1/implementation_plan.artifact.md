# Implementation Plan - Universal Typography & Branding Overhaul

Standardize the app's visual identity by applying Title Case to all headings, switching *all* prominent and large text to Modern Serif (Playfair Display), and removing all bold font weights project-wide.

## User Review Required

> [!WARNING]
> This is a project-wide change that will affect the appearance of every screen.
>
> 1. **Project-wide Weight Normalization**: I will replace all instances of `FontWeight.bold`, `w600`, `w700`, `w800`, and `w900` with `FontWeight.w500` (Medium) to ensure no text appears too dark or heavy.
> 2. **Universal Serif Font**: The `Playfair Display` font will be applied to all "Big Text" elements, including headings, buttons, and prominent labels (e.g., large numbers or hero text).

## Proposed Changes

### [Constants & Metadata]

#### [MODIFY] [AppString](file:///D:/Ajijul/spot_football_merketplace_app/lib/utils/constants/app_string.dart)
- Update all string constants to Title Case (e.g., `"Latest News"`, `"Upcoming Fixtures"`, `"Recent Results"`, `"Live Matches"`).

### [Common Components]

#### [MODIFY] [CommonText](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/text/common_text.dart)
- Update the default logic to apply `Playfair Display` for text above a certain size threshold (e.g., `fontSize >= 18`).
- Ensure no bold weights are applied by default.

#### [MODIFY] [CommonButton](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/button/common_button.dart)
- Set default `titleWeight` to `w500`.
- Apply `GoogleFonts.playfairDisplay()` to all button text.

### [Screens & Feature UI]

#### [MODIFY] [OnboardingScreen], [SignInScreen], [SignUpScreen]
- Update welcome headings and large labels (e.g., "Welcome back", "Login", "Create Account") to use Title Case and Playfair Display.

#### [MODIFY] Home Screen Widgets
- Ensure `LatestNews`, `UpcomingEvents`, `LeaguePreview`, `LiveMatches`, `RecentResults`, and `BookScoutSection` headings are Title Case and Playfair Display.

#### [MODIFY] Player & Club Profiles
- Update "Personal Details", "Eng Record", "Recent Performance", and "Total Squads" headings.

### [Global Audit]

#### [REPLACE] Project-wide Style Normalization
- Search and replace all `FontWeight` declarations:
    - `FontWeight.bold` -> `FontWeight.w500`
    - `FontWeight.w600` -> `FontWeight.w500`
    - `FontWeight.w700` -> `FontWeight.w500`
    - `FontWeight.w800` -> `FontWeight.w500`

## Verification Plan

### Manual Verification
- **Audit Screen-by-Screen**:
    - Verify that every heading is Title Case.
    - Verify that all "Big Text" (Onboarding headers, Auth headers, Section titles, Buttons) uses the Serif font.
    - Verify that absolutely no text appears bold or excessively dark compared to its surroundings.
- **Consistency Check**: Ensure "Sign Up" and "Fixtures" headings look identical in style.
