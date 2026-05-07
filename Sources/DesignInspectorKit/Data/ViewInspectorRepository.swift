import UIKit

/// Concrete implementation of `InspectorRepository`.
/// Delegates to `ViewHierarchyInspector` and `UIView` traversal extensions.
///
/// Equivalent to `ViewInspectorRepository` in DesignInspectorKit (Android).
final class ViewInspectorRepository: InspectorRepository {

    func findView(in root: UIView, atWindowPoint point: CGPoint) -> UIView? {
        if #available(iOS 19.0, *) {
            return root.deepestInspectableView(atWindowPoint: point)
        } else {
            let localPoint = root.convert(point, from: root.window)
            return root.deepestView(at: localPoint)
        }
    }

    func frame(of view: UIView, in coordinateSpace: UIView) -> CGRect {
        return view.convert(view.bounds, to: coordinateSpace)
    }

    func inspect(_ view: UIView, configuration: InspectorConfiguration) -> ViewInspectorInfo {
        return ViewHierarchyInspector(configuration: configuration).inspectSingle(view)
    }
}
