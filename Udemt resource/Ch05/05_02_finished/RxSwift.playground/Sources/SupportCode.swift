import Foundation

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

public func delay(_ delay: TimeInterval, action: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        action()
    }
}
