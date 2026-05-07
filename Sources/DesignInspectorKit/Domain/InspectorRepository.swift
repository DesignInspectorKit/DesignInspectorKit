import UIKit

/// Contract for the inspector data layer.
/// Abstracts view traversal and property extraction — easy to mock in unit tests.
///
/// Equivalent to `InspectorRepository` in DesignInspectorKit (Android).
public protocol InspectorRepository {

    /// Returns the deepest inspectable view at the given window-space point within `root`.
    func findView(in root: UIView, atWindowPoint point: CGPoint) -> UIView?

    /// Returns the frame of `view` converted to `coordinateSpace`.
    func frame(of view: UIView, in coordinateSpace: UIView) -> CGRect

    /// Extracts all inspectable properties from `view`.
    func inspect(_ view: UIView, configuration: InspectorConfiguration) -> ViewInspectorInfo
}
