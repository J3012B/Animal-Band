import SpriteKit
import UIKit

public class BandScene: SKScene {
    
    var containerSize: CGSize!
    
    public override init(size: CGSize) {
        super.init(size: size)
        
        let containerLength = CGFloat(min(Float(size.width), Float(size.height)))
        containerSize = CGSize(width: containerLength, height: containerLength)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func didMove(to view: SKView) {
        addElements()
    }
    
    
    /*
     ===================================================================
     ============================= TOUCHES =============================
     */
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    /*
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
     for t in touches { touchMoved(toPoint: t.location(in: self)) }
     }
     
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     for t in touches { touchUp(atPoint: t.location(in: self)) }
     }
     
     override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
     for t in touches { touchUp(atPoint: t.location(in: self)) }
     }
     
     */
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    /*
     ===================================================================
     ============================= SPRITES =============================
     */
    
    private func addElements() {
        addBackground()
        addGround()
    }
    
    private func addBackground() {
        let background = SKSpriteNode(color: UIColor(hex: "A3EEFF"), size: CGSize(width: frame.width, height: frame.height))
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        background.zPosition = -100
        
        
        self.addChild(background)
    }
    
    private func addGround() {
        let groundTex = SKTexture(imageNamed: "ground.png")
        let ground = SKSpriteNode(texture: groundTex, size: CGSize(width: 2*frame.width, height: 0.4 * containerSize.height))
        /*let ground = SKSpriteNode(color: UIColor.brown,
                                  size: CGSize(width: frame.width, height: 0.4 * containerSize.height))*/
        ground.position = CGPoint(x: 0, y: 0)
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        ground.zPosition = -90
        ground.texture = groundTex
        ground.texture?.filteringMode = .nearest
        
        self.addChild(ground)
    }
}

