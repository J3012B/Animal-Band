import UIKit

public class NoteView: UIView {
    
    let colorUnselected: UIColor = UIColor(hex: "#2C3E50")
    let colorSelected: UIColor = UIColor(hex: "#27AE60")
    
    var isSelected: Bool = false {
        didSet {
            if self.isSelected {
                self.backgroundColor = colorSelected
            } else {
                self.backgroundColor = colorUnselected
            }
        }
    }
    var note: Note?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hex: "#808B96").cgColor
        
        self.backgroundColor = colorUnselected
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // toggle the state of the note view when touched
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.tapCount == 2 {
                self.toggle()
            }
        }
    }
    
    // toggle the state of the note view
    func toggle() {
        if self.isSelected {
            self.backgroundColor = colorUnselected
        } else {
            self.backgroundColor = colorSelected
        }
        self.isSelected = !self.isSelected
    }
    
    
}
