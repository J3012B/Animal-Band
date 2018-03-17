import SpriteKit
import Foundation


public class SceneView: SKView {
    
    public init(size: CGSize) {
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        
        let bandScene = BandScene(size: size)
        bandScene.scaleMode = .aspectFill
        
        self.presentScene(bandScene)
        
        self.showsNodeCount = true
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
