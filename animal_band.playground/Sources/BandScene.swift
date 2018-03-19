import SpriteKit
import UIKit
import AVFoundation

public class BandScene: SKScene {
    
    var currentSong: Song?
    var currentTimeStep: Int = 0
    var notePlayers: [NotePlayer] = []
    
    var containerSize: CGSize!
    
    var stage: SKSpriteNode!
    
    public override init(size: CGSize) {
        super.init(size: size)
        
        let containerLength = CGFloat(min(Float(size.width), Float(size.height)))
        containerSize = CGSize(width: containerLength, height: containerLength)
        
        loadSong(filePath: "songs/alle_meine_entchen")
        prepareAudio()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func didMove(to view: SKView) {
        //loadSong(filePath: "songs/alle_meine_entchen")
        
        addElements()
    }
    
    /*
     ===================================================================
     ============================== SONGS ==============================
     */
    
    private func loadSong(filePath: String) {
        self.currentSong = Song(filePath: filePath)
        
        print("BandScene.loadSong >> Loaded song with path '\(filePath)'")
    }
    
    /*
     ===================================================================
     ============================== BAND ===============================
     */
    
    private func prepareAudio() {
        //player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "sounds/piano/c2", withExtension: "mp3")!)
        //player?.prepareToPlay()
    }
    
    private func playSong() {
        if self.currentSong != nil {
            
            for (instrument, notes) in self.currentSong!.instruments {
                //print(instrument)
                
                for note in notes {
                    //print(instrument + " plays a " + note.pitch! + "\(note.octave!) at \(note.time!)")
                    
                    do {
                        let filePath = "sounds/\(instrument)/\(note.pitch!)\(note.octave!)"
                        
                        if let notePlayerPath = Bundle.main.url(forResource: filePath, withExtension: "mp3") {
                            let newNotePlayer = NotePlayer(player: try AVAudioPlayer(contentsOf: notePlayerPath), timeToPlay: note.time)
                            
                            self.notePlayers += [newNotePlayer]
                            
                            print("Created new note player")
                        }
                    } catch {
                        print("BandScene.playSong >> Could not create note player")
                    }
                }
            }
            
            _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playTimeStep), userInfo: nil, repeats: false)

        }
    }
    
    @objc private func playTimeStep(aTimer: Timer) {
        print("Current Time Step is: \(self.currentTimeStep)")
        
        // calculate length of song
        var songIsOver = false
        var notesPlayed = 0
        var notePlayersToPlay = [NotePlayer]()
        
        if self.currentTimeStep >= self.currentSong!.length {
            songIsOver = true
        }
        
        if songIsOver {
            // reset everything here
            self.currentTimeStep = 0
            self.notePlayers = []
        } else {
            for notePlayer in self.notePlayers {
                if notePlayer.timeToPlay == self.currentTimeStep {
                    notePlayersToPlay.append(notePlayer)
                }
            }
            
            for notePlayer in notePlayersToPlay {
                notePlayer.player.play()
                notesPlayed += 1
            }
            
            self.currentTimeStep += 1
            
            let sixteenths = Double(15) / Double(self.currentSong!.tempo)
            print("Played \(notesPlayed) notes")
            print("Length of 16th is: \(self.currentSong!.tempo)")
            _ = Timer.scheduledTimer(timeInterval: sixteenths, target: self, selector: #selector(playTimeStep), userInfo: nil, repeats: false)
        }
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

