import UIKit

public class NoteField: UIScrollView {
    
    var noteViews = [NoteView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentSize = CGSize(width: 500.0, height: 700.0)
        self.bounces = false
        self.indicatorStyle = .white
        self.backgroundColor = UIColor(hex: "#ABB2B9")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
}

