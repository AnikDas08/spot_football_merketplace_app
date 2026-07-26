# Implementation Plan - Unify Pitch Visuals in Match Info

Ensure the stadium/pitch visual in the **Lineups Tab** correctly displays player avatars and names by synchronizing its logic and structure with the **Overview Tab**.

## Proposed Changes

### [Match Info Components]

#### [MODIFY] [Lineups Tab](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/match_info/presentation/widgets/line_up_tab.dart)
- **Refactor `_PitchNode`**: Update the `_PitchNode` widget to match `OverviewTab`'s node logic perfectly.
- **Synchronize Pitch Build Logic**:
    - Re-implement the pitch rendering logic within the `Obx` block to ensure it uses the exact same `starters` filtering and `positionIndex` matching as `OverviewTab`.
    - Wrap the pitch `Row` in the same layout constraints (e.g., ensuring it fills the `AspectRatio` container correctly).
- **Consolidate Styles**: Use the identical font sizes, colors, and border widths from the working `OverviewTab`.

#### [MODIFY] [Overview Tab](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/match_info/presentation/widgets/overview_tab.dart)
- Minor adjustments if any improvements are found during the `LineupsTab` refactor (e.g., ensuring consistency in fallback text).

## Verification Plan

### Manual Verification
- **Visual Match**: Verify that the pitch section in the "Lineups" tab now shows player avatars and names just like the "Overview" tab.
- **Interactivity**: Toggle between Home and Away teams in the "Lineups" tab and verify the pitch updates immediately.
- **Empty State Check**: Ensure that nodes without assigned players still show placeholder circles.
