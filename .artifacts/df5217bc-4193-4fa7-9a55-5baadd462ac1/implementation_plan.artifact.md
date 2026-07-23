# Implementation Plan - Comprehensive Default Profile Image Standardization

Standardize the default profile image across the entire application to use the ENG logo (`AppImages.appLogo`) whenever a player or user profile image is missing, empty, or fails to load.

## User Review Required

> [!IMPORTANT]
> This change will globally replace all profile placeholders (silhouettes, generic player images, etc.) with the ENG logo. This ensures a consistent, branded experience in player lists, lineups, the drawer, and management screens.

## Proposed Changes

### [Common Components]

#### [MODIFY] [CommonImage](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/image/common_image.dart)
- Update `defaultImage` default value to `AppImages.appLogo`.
- Enhance the `build` method to explicitly check if `imageSrc` is empty or null. If so, return `_buildErrorWidget()` (the default logo).

### [UI Components & Screens - Comprehensive Audit]

I will remove manual fallbacks and ensure `CommonImage` handles the branding in the following locations:

#### [MODIFY] [AppDrawer](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/drawer/presentation/screen/app_drawer.dart)
- Remove manual ternary check for `image.isEmpty`.
- Let `CommonImage` handle the default logo for the logged-in user.

#### [MODIFY] [ClubProfileScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/home/presentation/screens/club_profile_screen.dart)
- In `_PlayerRow`, replace manual `Image.asset(TempImage.playerWithFootball)` with a clean `CommonImage` call.

#### [MODIFY] [TeamSheetScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/team_sheet/presentation/screen/team_sheet_screen.dart)
- In `_buildPlayerNode` (tactical board nodes), use the default logo instead of initials when no image exists, for a cleaner look.
- In `_buildSubstitutesList` and the player selection bottom sheet, ensure `CommonImage` is used without manual fallbacks.

#### [MODIFY] [LineupsTab](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/match_info/presentation/widgets/line_up_tab.dart)
- Update `_PitchNode` and `_PlayerRow` to use the standardized default logo.

#### [MODIFY] [RecordGoalScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/live_match_control/presentation/screen/record_goal_screen.dart)
- Update the horizontal player list in `_buildPlayerList` to use the new default.

#### [MODIFY] [PlayerHeaderWidget](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/player_profile/presentation/widgets/player_header_widget.dart)
- Update the large player image fallback in the header.

#### [MODIFY] [MyChildrenScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/profile/presentation/screens/my_children_screen.dart)
- Standardize the athlete list avatars.

#### [MODIFY] [EditProfile](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/profile/presentation/screen/edit_profile.dart)
- Standardize the profile image preview placeholder.

## Verification Plan

### Manual Verification
- **Drawer & Profiles**: Navigate through App Drawer, Club Profiles, and Match Lineups. Verify that any player/user without an image shows the ENG logo.
- **Management**: Open the Team Sheet and Record Goal screens. Verify avatars in lists and on the tactical board.
- **Branding Check**: Ensure the logo is properly sized (contain/cover) in each context to maintain a professional look.
