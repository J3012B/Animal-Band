import UIKit

public class SongTableViewCell: UITableViewCell {
    
    private var dot: UIView!
    
    public var addedElements: Bool = false
    public var song: String! = "" {
        didSet {
            self.textLabel?.text = song
        }
    }
    public var isChosen: Bool = false {
        didSet {
            self.dot.isHidden = !self.isChosen
        }
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    public func addElements() {
        let padding = frame.height * 0.3
        let dotHeight = frame.height - 2 * padding
        dot = UIView(frame: CGRect(x: frame.width - padding, y: padding, width: dotHeight, height: dotHeight))
        dot.backgroundColor = UIColor.black
        dot.layer.cornerRadius = dot.frame.height * 0.5
        dot.isHidden = true
        
        self.addSubview(dot)
        
        self.addedElements = true
    }
    
}
