import SpriteKit

public class Animal: SKSpriteNode {
    
    private let frameDict = ["cat": 4, "dog": 2, "turtle": 2, "monkey": 4]
    private let durationDict = ["cat": 0.3, "dog": 0.5, "monkey": 0.4, "turtle": 0.45]
    
    private var frames: [SKTexture]?
    private var minHeight: CGFloat!
    public var isDragged: Bool = false
    public var type: String!
    
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
        
        self.prepareAnimation()
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
    
    private func prepareAnimation() {
        self.frames = [SKTexture]()
        
        for i in 0..<frameDict[self.type!]! {
            let frame = SKTexture(imageNamed: "animals/\(type!)_playing/\(type!)_playing_\(i).png")
            frame.filteringMode = .nearest
            frames!.append(frame)
        }
    }
    
    public func startAnimation() {
        if frames != nil {
            let animate = SKAction.animate(with: frames!, timePerFrame: durationDict[type!]!)
            let forever = SKAction.repeatForever(animate)
            self.run(forever)
        }
    }
    
    public func stopAnimate() {
        self.removeAllActions()
        self.texture = SKTexture(imageNamed: "animals/\(type!).png")
        self.texture!.filteringMode = .nearest
    }
    
    
}

