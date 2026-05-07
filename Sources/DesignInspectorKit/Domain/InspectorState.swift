import UIKit

/// Represents the UI state of the inspector overlay.
/// Used as the single source of truth in `InspectorViewModel`.
///
/// Equivalent to `InspectorState` in DesignInspectorKit (Android).
public enum InspectorState: Equatable {

    /// Inspector is not active — overlay is not presented.
    case idle

    /// Inspector is active, waiting for the user to tap a view.
    case active

    /// A view has been tapped and its info is ready to display.
    case selected(InspectorSelection)

    public static func == (lhs: InspectorState, rhs: InspectorState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.active, .active): return true
        case (.selected(let a), .selected(let b)): return a.info.className == b.info.className
        default: return false
        }
    }
}

/// The data associated with a selected view.
public struct InspectorSelection {
    /// The frame of the selected view in the overlay's coordinate space.
    public let frameInOverlay: CGRect
    /// The frame of the selected view's superview in the overlay's coordinate space. `nil` if no superview.
    public let superviewFrameInOverlay: CGRect?
    /// The inspected properties of the selected view.
    public let info: ViewInspectorInfo
}
