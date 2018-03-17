import SpriteKit
import Foundation


public class SceneView: SKView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let bandSceneWidth = min(frame.size.width, frame.size.height)
        let bandScene = BandScene(size: CGSize(width: bandSceneWidth, height: bandSceneWidth))
        bandScene.scaleMode = .aspectFit
        
        self.presentScene(bandScene)
        
        self.showsNodeCount = true
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
