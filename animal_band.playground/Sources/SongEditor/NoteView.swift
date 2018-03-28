import UIKit

public class NoteView: UIView {
    
    let colorUnselected: UIColor = UIColor(hex: "#2C3E50")
    let colorSelected: UIColor = UIColor(hex: "#27AE60")
    
    var isSelected: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = colorUnselected
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.tapCount == 2 {
                self.toggle()
            }
        }
    }
    
    
    func toggle() {
        if self.isSelected {
            self.backgroundColor = colorUnselected
        } else {
            self.backgroundColor = colorSelected
        }
        self.isSelected = !self.isSelected
    }
    
    
}
