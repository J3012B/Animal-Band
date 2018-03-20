import SpriteKit

public class Animal: SKSpriteNode {
    
    public init(imageNamed: String, sceneSize: CGSize) {
        // load texture
        let tex = SKTexture(imageNamed: "Animals/" + imageNamed)
        super.init(texture: tex, color: UIColor.clear, size: tex.size())
        
        self.texture?.filteringMode = .nearest
        self.position = CGPoint(x: 0, y: 0)
        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        self.scaleTo(newHeight: tex.size().height / 256 * sceneSize.height)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

