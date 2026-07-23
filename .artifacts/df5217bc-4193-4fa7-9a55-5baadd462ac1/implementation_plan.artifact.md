# Implementation Plan - Universal Auth Background & Final Branding

Apply the `auth_bg.png` background and Title Case consistency to all remaining authentication and onboarding screens. Refine the App Bar action buttons and ensure all text weights and fonts are aligned with the premium brand identity.

## User Review Required

> [!IMPORTANT]
> - All authentication-related screens (Forget Password, Verify, Create Password, Select Role, etc.) will now use the **full-screen `auth_bg.png`** with a dark gradient overlay.
> - **Sign Up / Sign In / Forget Password / Verify** headers will be set to `FontWeight.w500` to avoid being "too bold".
> - The **"Play The Game"** text on the Onboarding screen and the **"Welcome To"** text will strictly use the **Montserrat** font family as requested.

## Proposed Changes

### [Authentication Screens]
The following screens will be wrapped in a `Stack` with the full-screen background and gradient:
1.  **Forgot Password** (`forgot_password.dart`)
2.  **Verify OTP** (`verify_screen.dart` and `verify_user.dart`)
3.  **Create/Reset Password** (`create_password.dart`)
4.  **Role Selection** (`select_role.dart`)
5.  **Role Registration Info** (`verify_player_screen.dart`, `manager_registation_screen.dart`, `referee_info_screen.dart`, `trial_registration_screen.dart`)

**Styling for these screens:**
- `extendBodyBehindAppBar: true` and `extendBody: true`.
- Titles/Labels/Subtitle text set to `Colors.white` or `Colors.white70`.
- All `CommonTextField` instances updated with `fillColor: Colors.white.withOpacity(0.1)` and `textColor: Colors.white`.
- App Bar set to transparent.

### [Branding & Case Consistency]

#### [MODIFY] [AppString](file:///D:/Ajijul/spot_football_merketplace_app/lib/utils/constants/app_string.dart)
- Manually audit and fix any remaining non-Title Case strings.
- Example: `"News details"` -> `"News Details"`, `"Select your role"` -> `"Select Your Role"`.

#### [MODIFY] [NavBarController](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/navbar/controller/navbar_controller.dart)
- Update bottom navigation labels to Title Case: "Home", "Fixtures", "Leagues", "Eng TV", "Stats".

### [UI Components]

#### [MODIFY] [CommonAppbar](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/common_appbar/common_appbar.dart)
- Reduce the size of the Notification and Menu buttons (set height/width to `36.h`, icon size to `18.sp`).
- Ensure the unread count text uses `Playfair Display`.

## Verification Plan

### Manual Verification
- **Visual Audit**: Navigate through the entire sign-up and forgot-password flows.
    - Confirm the background image is present and full-screen on every step.
    - Confirm all headings are Title Case.
    - Confirm no text appears "Extra Bold" (all should be `w500`).
- **Onboarding Check**: Verify "Play The Game" and "Welcome To" use Montserrat.
- **App Bar Check**: Verify action buttons are compact and properly aligned.
