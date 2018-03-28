import UIKit

/* Menu, from which you can pick song jsons from the song directory */

public class SongSelectionView: UIViewLayer {
    
    
    /*  INITIALIZATION  */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isHidden = true
        
        addElements()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    public func reset() {
        
    }
    
    public func show() {
        self.reset()
        self.isHidden = false
        
    }
    
    
    private func addElements() {
        /**/
        
    }
}

