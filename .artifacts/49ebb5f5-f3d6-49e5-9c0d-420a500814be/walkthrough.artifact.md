# Walkthrough - Refactored League Tables Screen

I have refactored the League Tables screen to support dynamic filtering via bottom sheets, infinite scrolling for all league tables, and a themed year picker.

## Changes Made

### Dynamic Filtering & Bottom Sheets
- **League Selection**: Replaced the static dropdown with a searchable [`CommonSelectionSheet`](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/sheet/common_selection_sheet.dart). By default, **"All"** is selected, which fetches and displays all available league tables.
- **Year Selection**: Implemented a custom [`YearPickerSheet`](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/sheet/year_picker_sheet.dart) that displays a list of years from the current year backwards. This replaces the old semi-static season dropdown.
- **Selection Trigger**: Used the new [`SelectionTriggerWidget`](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/widget/selection_trigger_widget.dart) to provide a consistent look for the filter buttons.

### UI & Performance
- **Infinite Scrolling**: Implemented a scroll-based pagination system in the new [`LeagueTablesController`](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/league_tables/presentation/controller/league_tables_controller.dart). The screen now loads more tables automatically as you scroll down.
- **Sectioned Layout**: The screen now displays each league as a separate section with its own header and standings table, providing a comprehensive overview of all leagues.
- **Themed Shimmers**: Added a specific `TableShimmer` to provide a smooth loading experience that matches the new sectioned layout.

### Data Management
- Created a dedicated `LeagueTablesController` to manage the complex state of multiple tables, pagination, and multi-parameter filtering, keeping the logic clean and decoupled.

## How to Verify
1. **Navigate to Tables**: Open the "Tables" tab from the bottom navigation.
2. **Default View**: Verify that you see a list of multiple league tables for the current year.
3. **League Filter**: Tap the first filter button, select a specific league, and verify only that table is displayed.
4. **Year Filter**: Tap the second filter button, select a different year, and verify the data refreshes for that year.
5. **Scroll & Paginate**: Set the league filter back to "All" and scroll to the bottom to see more tables loading dynamically.
