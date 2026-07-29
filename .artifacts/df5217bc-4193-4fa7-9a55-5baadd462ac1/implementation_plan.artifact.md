# Implementation Plan - Dynamic Stats & Typography Alignment

Update the Stats Screen to use dynamic leagues from the API, apply Title Case to all buttons/labels, and synchronize typography with the Home Screen's title style.

## Proposed Changes

### [Stats Feature]

#### [MODIFY] [StatsController](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/stats_flow/presentation/controller/stats_controller.dart)
- Fetch the list of real leagues from `ApiEndPoint.leagues` on initialization.
- Store the league names in a dynamic list.
- Update `selectedAge` (rename to `selectedLeagueName`) to default to the first available league from the API.
- Ensure `fetchLeagueSummary` correctly uses the selected league name as a query parameter.

#### [MODIFY] [StatsScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/stats_flow/presentation/screen/stats_screen.dart)
- **Label Update**: Change the filter label from "Under" to **"Filter By League"** (Title Case).
- **Button Update**: Use **"Season Stats"** and **"Player Comparison"** (Title Case, not All Caps).
- **Typography Sync**: Apply `PlayfairDisplay` font family to:
    - The "Statistics" title.
    - The "2026/27 Top Stats" subtitle.
    - The "Filter By League" dropdown value (size 16).
    - The "Season Stats" and "Player Comparison" buttons.

#### [MODIFY] [SeasonStatsButton](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/stats_flow/presentation/widget/season_stats_button.dart)
- Explicitly set `fontFamily: 'PlayfairDisplay'` for the button text to match the new brand direction for large text elements.

## Verification Plan

### Manual Verification
- **Dynamic Data**: Open the Stats screen and verify that the dropdown contains real league names (e.g., "Under 19", "Under 20") instead of hardcoded numbers.
- **Title Case**: Ensure all buttons and the filter label use Title Case ("Season Stats", not "SEASON STATS").
- **Typography**: Check that all text size 14 and above in this screen uses the serif `PlayfairDisplay` font.
- **API Call**: Change a league in the dropdown and verify that the player stats grid (Top Scorer, Assists, etc.) updates accordingly.
