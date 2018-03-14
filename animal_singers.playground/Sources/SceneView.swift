import SpriteKit
import Foundation


public class SceneView: SKView {
    
    public init(size: CGSize) {
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        
        let choirScene = ChoirScene(size: size)
        choirScene.scaleMode = .aspectFill
        
        self.presentScene(choirScene)
        
        self.showsNodeCount = true
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
