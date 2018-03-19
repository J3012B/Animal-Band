import SpriteKit
import UIKit
import AVFoundation

public class BandScene: SKScene {
    
    var player: AVAudioPlayer?
    
    var containerSize: CGSize!
    
    var stage: SKSpriteNode!
    
    public override init(size: CGSize) {
        super.init(size: size)
        
        let containerLength = CGFloat(min(Float(size.width), Float(size.height)))
        containerSize = CGSize(width: containerLength, height: containerLength)
        
        prepareAudio()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func didMove(to view: SKView) {
        prepareSongInstructions(filePath: "songs/alle_meine_entchen")
        
        addElements()
    }
    
    /*
     ===================================================================
     =========================== LOAD SONGS ============================
     */
    
    /*
    private func readJson(fileName: String) {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: ".json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }*/
    
    private func prepareSongInstructions(filePath: String) {
        if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let song = jsonResult as? Dictionary<String, AnyObject>, let info = song["info"] as? [String: Int] {
                    //print("JSON result is \(jsonResult) and type of it is: \(type(of: jsonResult))")
                    print("Song info is: \(info)");
                    print("Tempo is: \(info["tempo"]!)")
                }
            } catch {
                print("BandScene.prepareSongInstructions >> Could not prepare song instructions for '\(filePath)'")
            }
        }
        
        /*
        do {
            if let data = try Data(contentsOf: Bundle.main.url(forResource: fileName, withExtension: ".json")!) as String? {
                let jsonData = jsonString.data(encoding: .utf8)!
                let decoder = JSONDecoder()
                let song = try! decoder.decode(Song.self, for: jsonData)
                
                print("The info of song is: " +  song)
            } else {
                print("Couldn't load JSON")
            }
        } catch {
            print(error.localizedDescription)
        }*/
    }
    
    /*
     ===================================================================
     ============================== BAND ===============================
     */
    
    private func prepareAudio() {
        player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "sounds/piano/c2", withExtension: "mp3")!)
        player?.prepareToPlay()
    }
    
    private func playSong() {
        print("play c2")
        
        player?.play()
        
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
        addSetting()
        addAnimals()
        addMenu()
    }
    
    private func addSetting() {
        addBackground()
        addWall()
        addStage()
        addGround()
    }
    
    private func addBackground() {
        let background = SKSpriteNode(color: UIColor.gray, size: CGSize(width: frame.width, height: frame.height))
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        background.zPosition = -100
        
        
        self.addChild(background)
    }
    
    private func addWall() {
        let wall = SKSpriteNode(color: UIColor.red, size: CGSize(width: frame.width, height: frame.height * 7 / 16))
        wall.position = CGPoint(x: 0.0, y: frame.height)
        wall.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        wall.zPosition = -91
        
        self.addChild(wall)
    }
    
    private func addStage() {
        let stageTex = SKTexture(imageNamed: "stage.png")
        stage = SKSpriteNode(color: UIColor.brown, size: CGSize(width: frame.width, height: frame.height * 5 / 16))
        stage.position = CGPoint(x: 0.0, y: frame.height * 0.25)
        stage.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        stage.zPosition = -90
        stage.texture = stageTex
        stage.texture?.filteringMode = .nearest
        
        self.addChild(stage)
    }
    
    private func addGround() {
        let groundTex = SKTexture(imageNamed: "ground.png")
        let ground = SKSpriteNode(color: UIColor.blue, size: CGSize(width: frame.width, height: frame.height * 0.25))
        ground.position = CGPoint(x: 0, y: 0)
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        ground.zPosition = -89
        ground.texture = groundTex
        ground.texture?.filteringMode = .nearest
        
        self.addChild(ground)
    }
    
    /*
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
    }*/
 
    
    private func addAnimals() {
        let animalPianoCat = SKSpriteNode(imageNamed: "Animals/Piano_Cat/piano_cat.png")
        animalPianoCat.position = CGPoint(x: 200.0, y: 100.0)
        animalPianoCat.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        animalPianoCat.texture?.filteringMode = .nearest;
        animalPianoCat.scaleTo(newHeight: 0.1875 * frame.height)
        
        stage.addChild(animalPianoCat)
    }
    
    
    private func addMenu() {
        let menuWidth = frame.width * 0.9
        let menuHeight = frame.height * 0.1
        let menuMargin = (frame.width - menuWidth) * 0.5
        let menu = SKSpriteNode(color: UIColor.green, size: CGSize(width: menuWidth, height: menuHeight))
        menu.position = CGPoint(x: menuMargin, y: frame.height - menuMargin)
        menu.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        menu.zPosition = 100
        
        /* Play Button */
        let playBtn = SKButton(defaultButtonImage: "Menu/Play_Button/playButton_default.png", activeButtonImage: "Menu/Play_Button/playButton_active.png", buttonAction: playSong)
        playBtn.scaleTo(newHeight: menu.frame.height)
        playBtn.position = CGPoint(x: menu.frame.width, y: 0.0)
        playBtn.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        playBtn.color = UIColor.yellow
        
        menu.addChild(playBtn)
        
        self.addChild(menu)
    }
}

