# Fix Empty Space in League Preview Walkthrough

I have optimized the `HomeScreen` to prevent empty spaces or duplicate padding from being rendered when a league has no standings data.

## Changes Made

### 1. Home Screen Logic Optimization
Updated the `HomeScreen` widget to filter the `allLeagues` list before mapping it to the UI.

- **Before**: The loop iterated over every league returned by the API. Even if a league had no data, the `_buildSection` wrapper (which contains 32dp vertical padding and a white background) was rendered, creating large white gaps on the screen.
- **After**: Added a `.where((leagueData) => leagueData.standings.isNotEmpty)` filter. Now, the section wrapper and the `LeaguePreview` widget are only generated for leagues that actually have standings to display.

## Verification Results

- [x] **No Gaps**: Verified that leagues with empty `standings` arrays no longer create empty white boxes on the Home Screen.
- [x] **Correct Header**: The "League Preview" title still appears correctly on the first valid league table.
- [x] **Performance**: Filtering the list in-memory is efficient and doesn't impact scroll performance.

render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/home/presentation/screens/home_screen.dart)
