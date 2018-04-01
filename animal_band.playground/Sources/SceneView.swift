import SpriteKit
import Foundation


public class SceneView: SKView {
    
    public var bandScene: BandScene!
    
    public init(frame: CGRect, audienceApplauses: Bool) {
        super.init(frame: frame)
        
        
        let bandSceneWidth = min(frame.size.width, frame.size.height)
        self.bandScene = BandScene(size: CGSize(width: bandSceneWidth, height: bandSceneWidth), audienceApplauses: audienceApplauses)
        self.bandScene.scaleMode = .aspectFit
        
        self.presentScene(self.bandScene)
        
        self.showsNodeCount = false
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
