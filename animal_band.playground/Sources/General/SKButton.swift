import Foundation
import SpriteKit

public class SKButton: SKSpriteNode {
    private var defaultButton: SKSpriteNode
    private var activeButton: SKSpriteNode
    private var action: () -> Void
    
    public init(defaultButtonImage: String, activeButtonImage: String, buttonAction: @escaping () -> Void) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        
        defaultButton.position = CGPoint(x: 0.0, y: 0.0)
        activeButton.position = CGPoint(x: 0.0, y: 0.0)
        
        defaultButton.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        activeButton.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        
        defaultButton.texture?.filteringMode = .nearest
        activeButton.texture?.filteringMode = .nearest
        
        activeButton.isHidden = true
        action = buttonAction
        
        super.init(texture: nil, color: UIColor.clear, size: defaultButton.size)
        
        isUserInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeButton.isHidden = false
        defaultButton.isHidden = true
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = Array(touches)[0] as UITouch
        let location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location) {
            activeButton.isHidden = false
            defaultButton.isHidden = true
        } else {
            activeButton.isHidden = true
            defaultButton.isHidden = false
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = Array(touches)[0] as UITouch
        let location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location) {
            action()
        }
        
        activeButton.isHidden = true
        defaultButton.isHidden = false
    }
}
