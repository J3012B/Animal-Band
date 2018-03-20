import SpriteKit

public class Animal: SKSpriteNode {
    
    var minHeight: CGFloat!
    
    public init(imageNamed: String, sceneSize: CGSize) {
        // load texture
        let tex = SKTexture(imageNamed: "Animals/" + imageNamed)
        super.init(texture: tex, color: UIColor.clear, size: tex.size())
        
        self.texture?.filteringMode = .nearest
        self.position = CGPoint(x: 0, y: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleTo(newHeight: tex.size().height / 256 * sceneSize.height)
        self.minHeight = self.frame.height
        
        self.updateSize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public func updateSize() {
        if let stage = self.parent as? SKSpriteNode {
            let relative = 1.3 - 0.3 * (self.position.y / stage.frame.height) // between 1.0 and 1.5
            
            self.scaleTo(newHeight: relative * minHeight)
        }
    }
}

