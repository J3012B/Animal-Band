import UIKit

public class AnimalBandView: UIView {
    
    
    public init(size: CGSize) {
        super.init(frame: CGRect(x:0, y: 0, width: size.width, height: size.height))
        
        addSubViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addSubViews() {
        /* Add SK Scene View */
        let sceneViewFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let sceneView = SceneView(frame: sceneViewFrame)
        
        self.addSubview(sceneView)
    }
}

