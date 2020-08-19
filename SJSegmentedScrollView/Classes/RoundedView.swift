import UIKit

public class RoundedSelectedView: UIView {
    public override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.toRound()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.toRound()
    }
    
    private func toRound() {
        self.layer.cornerRadius = self.frame.size.height * 0.5
        self.layer.masksToBounds = true
    }
}
