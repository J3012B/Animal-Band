import UIKit

public class SongEditorView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue
        
        self.addUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    /*
     ===================================================================
     ========================= User Interface ==========================
     */
    
    private func addUI() {
        self.addMenuBar()
    }
    
    private func addMenuBar() {
        let menuBarFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 0.2)
        let menuBar = UIView(frame: menuBarFrame)
        
        menuBar.backgroundColor = UIColor.yellow
        
        self.addSubview(menuBar)
    }
}

