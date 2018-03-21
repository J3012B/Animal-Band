import UIKit

public class AnimalBandView: UIView {
    
    
    public init(size: CGSize) {
        let mySize = size.width * 1.5 <= size.height ? CGSize(width: size.width, height: size.width * 1.5) : CGSize(width: size.height * (2/3), height: size.height)
        super.init(frame: CGRect(x:0, y: 0, width: mySize.width, height: mySize.height))
        
        addSubViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    
    private func addSubViews() {
        /* Add Song Editor here */
        let songEditorFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 0.33)
        let songEditorView = SongEditorView(frame: songEditorFrame)
        
        self.addSubview(songEditorView)
        
        /* Add SK Scene View */
        let sceneViewFrame = CGRect(x: 0, y: songEditorFrame.maxY, width: frame.width, height: frame.height * 0.67)
        let sceneView = SceneView(frame: sceneViewFrame)
        
        self.addSubview(sceneView)
    }
}

