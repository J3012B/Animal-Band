import SpriteKit

public class Animal: SKSpriteNode {
    
    var minHeight: CGFloat!
    var isDragged: Bool = false
    var type: String!
    
    public init(type: String, sceneSize: CGSize) {
        // load texture
        let tex = SKTexture(imageNamed: "animals/\(type).png")
        super.init(texture: tex, color: UIColor.clear, size: tex.size())
        
        self.texture?.filteringMode = .nearest
        self.position = CGPoint(x: 0, y: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.scaleTo(newHeight: tex.size().height / 256 * sceneSize.height)
        self.minHeight = self.frame.height
        self.type = type
        
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
    
    public func startAnimation() {
        let frameDict = ["cat": 4, "dog": 2, "turtle": 0]
        var frames = [SKTexture]()
        
        for i in 0..<frameDict[self.type!]! {
            let frame = SKTexture(imageNamed: "animals/\(type!)_playing/\(type!)_playing_\(i).png")
            frame.filteringMode = .nearest
            frames.append(frame)
        }
        
        //print("After the loop")
        
        if frames.count != 0 {
            let animate = SKAction.animate(with: frames, timePerFrame: 0.3)
            let forever = SKAction.repeatForever(animate)
            self.run(forever)
        }

        //print("end of startAnimation()")
    }
    
    public func stopAnimate() {
        self.removeAllActions()
        self.texture = SKTexture(imageNamed: "animals/\(type!).png")
        self.texture!.filteringMode = .nearest
    }
    
    
}

