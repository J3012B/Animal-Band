import UIKit

/* This class is a UIView with a dark transparent background */

public class UIViewLayer: UIView {
    
    public var userCanRemove: Bool = true
    
    /*  INITIALIZATION  */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            if userCanRemove {
                self.isHidden = true
            }
        }
    }
    
    
    
    
    private func addElements() {
        /* Add Background Layer */
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
    }
        
    
    
}
