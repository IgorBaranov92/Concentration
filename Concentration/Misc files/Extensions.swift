import Foundation
import UIKit

extension Array {
    mutating func removeRandomElement() -> Element {
        return remove(at: Int.random(in: 0..<self.count))
    }
}

protocol ConcentrationGameDelegate: class {
    func matchWasFound()
    func matchWasNotFound()
}


var isPotraitOrientation: Bool {
    return (UIDevice.current.orientation == .portraitUpsideDown || UIDevice.current.orientation == .portrait)
}

var isLandscapeOrientation: Bool {
    return (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight)
}
