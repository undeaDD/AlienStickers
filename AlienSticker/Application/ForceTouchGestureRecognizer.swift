import UIKit

class ForceTouchGestureRecognizer: UIGestureRecognizer {

    private var forceValue: CGFloat?
    private var minimumValue: CGFloat = 0.5
    private var tolerance: CGFloat = 0.2
    private var maxValue: CGFloat = 0

    override func reset() {
        super.reset()
        forceValue = nil
        maxValue = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if touches.count != 1 {
            state = .failed
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first!
        let value = touch.force / touch.maximumPossibleForce
        
        if state == .possible {
            
            if value > minimumValue {
                state = .began
            }
        } else {
            
            if value < (maxValue - tolerance) {
                state = .ended
            } else {
                maxValue = max(self.forceValue ?? 0, maxValue)
                self.forceValue = value
                state = .changed
            }
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        if state == .began || state == .changed {
            state = .cancelled
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        if state == .began || state == .changed {
            state = .ended
        }
    }

}
