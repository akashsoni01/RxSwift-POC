import Foundation

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

public extension Int {
    
    func isPrime() -> Bool {
        guard self > 1 else { return false }
        
        var isPrime = true
        
        (2..<self).forEach {
            if self % $0 == 0 {
                isPrime = false
            }
        }
        
        return isPrime
    }
}
