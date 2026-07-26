# Implementation Plan - Unify Stadium Visuals in Match Info

Synchronize the stadium/pitch visual in the **Lineups Tab** to match the styling and functionality of the **Overview Tab** within the Match Info screen.

## Proposed Changes

### [Match Info Components]

#### [MODIFY] [Lineups Tab](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/match_info/presentation/widgets/line_up_tab.dart)
- **Header Alignment**: Update the "Tactical Lineup" header to match the "Formation Setup" style from `OverviewTab`. Use `AppColors.primaryColor` for the background, increase padding to `16.h`, and set the font size to `18`.
- **Stadium Container**: Set the border color to `AppColors.colorEABB00` and ensure consistent border radius and shadow.
- **Pitch Nodes**: Refactor `_PitchNode` to match `OverviewTab`'s `_PlayerNode`:
    - Increase border width to `2.0`.
    - Correct the logic to show player **initials** when the profile image is missing, instead of falling back to the default logo (using a manual check before `CommonImage` or passing a specific flag).
    - Update name and position text styles (font size, weight, and colors) to be identical to the ones in `OverviewTab`.
- **Data Consistency**: Ensure the `starters` list is handled identically to the `OverviewTab` to avoid missing players on the pitch.

#### [MODIFY] [Overview Tab](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/match_info/presentation/widgets/overview_tab.dart)
- Update `_PlayerNode` to match any improved logic from `LineupsTab` if necessary (e.g., ensuring initials are only shown if a player is actually assigned to that node).

## Verification Plan

### Manual Verification
- **Visual Comparison**: Open the Match Info screen and toggle between the "Overview" and "Lineups" tabs. The stadium section should look identical in both tabs (header, colors, node styles).
- **Player Display**: Verify that player names and positions are visible below the pitch circles in both tabs.
- **Empty State Check**: Verify that nodes without assigned players show only the dashed circle or placeholder dot consistently.
- **Missing Image Check**: Verify that players without profile images show their initials inside the pitch circle in both tabs.
