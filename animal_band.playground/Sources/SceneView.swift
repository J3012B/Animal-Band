import SpriteKit
import Foundation


public class SceneView: SKView {
    
    public var bandScene: BandScene!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let bandSceneWidth = min(frame.size.width, frame.size.height)
        self.bandScene = BandScene(size: CGSize(width: bandSceneWidth, height: bandSceneWidth))
        self.bandScene.scaleMode = .aspectFit
        
        self.presentScene(self.bandScene)
        
        self.showsNodeCount = false
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
