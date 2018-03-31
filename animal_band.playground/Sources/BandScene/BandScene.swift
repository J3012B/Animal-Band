import SpriteKit
import UIKit
import AVFoundation

public class BandScene: SKScene {
    
    public var songEditorView: SongEditorView?
    
    var songObject: Song?
    var currentTimeStep: Int = 0
    var notePlayers: [NotePlayer] = []
    
    var animals = [Animal]()
    
    var containerSize: CGSize!
    
    var stage: SKSpriteNode!
    private var pauseBtn: SKButton!
    private var playBtn: SKButton!
    
    private var songIsOver = false
    
    public override init(size: CGSize) {
        super.init(size: size)
        
        let containerLength = CGFloat(min(Float(size.width), Float(size.height)))
        containerSize = CGSize(width: containerLength, height: containerLength)
        
        loadSong()
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
    
    private func loadSong() {
        print("Current Song, which will be played is: " + currentSong)
        self.songObject = Song(filePath: "songs/" + currentSong)
    }
    
    /*
     ===================================================================
     ============================== BAND ===============================
     */
    
    private func pauseButtonPushed() {
        self.songIsOver = true
    }
    
    private func playButtonPushed() {
        loadSong()
        prepareAudio()
        playSong()
        
        self.songEditorView!.songIsPlayingView.songStartedPlaying()
    }
    
    private func prepareAudio() {
        if self.songObject != nil {
            // Iterate through all instruments
            for (instrument, notes) in self.songObject!.instruments {
                // Iterate through all notes
                for note in notes {
                    do {
                        let filePath = "sounds/\(instrument)/\(note.pitch!)\(note.octave!)"
                        
                        // Create Audio Player for each note
                        if let notePlayerPath = Bundle.main.url(forResource: filePath, withExtension: "mp3") {
                            let newNotePlayer = NotePlayer(player: try AVAudioPlayer(contentsOf: notePlayerPath), timeToPlay: note.time)
                            newNotePlayer.player.volume = 0.7
                            newNotePlayer.player.prepareToPlay()
                            
                            self.notePlayers += [newNotePlayer]
                        }
                    } catch {
                        print("BandScene.playSong >> Could not create note player")
                    }
                }
            }
        }
    }
    
    private func playSong() {
        
        for animal in self.animals {
            animal.startAnimation()
        }
        
        self.songIsOver = false
        self.playBtn.isEnabled = false
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playTimeStep), userInfo: nil, repeats: false)

    }
    
    @objc private func playTimeStep(aTimer: Timer) {
        
        // calculate length of song
        var notesPlayed = 0
        var notePlayersToPlay = [NotePlayer]()
        
        if self.currentTimeStep >= self.songObject!.length {
            self.songIsOver = true
        }
        
        if self.songIsOver {
            endConcert()
            // reset everything here
        } else {
            for notePlayer in self.notePlayers {
                if notePlayer.timeToPlay == self.currentTimeStep {
                    if self.currentTimeStep % 8 == 0 {
                        notePlayer.player.volume = 1.0
                    }
                    notePlayersToPlay.append(notePlayer)
                }
            }
            
            for notePlayer in notePlayersToPlay {
                notePlayer.player.play()
                notesPlayed += 1
            }
            
            self.currentTimeStep += 1
            
            let sixteenths = Double(15) / Double(self.songObject!.tempo)
            _ = Timer.scheduledTimer(timeInterval: sixteenths, target: self, selector: #selector(playTimeStep), userInfo: nil, repeats: false)
        }
    }
    
    private func endConcert() {
        self.songIsOver = true
        self.currentTimeStep = 0
        self.notePlayers = []
        self.playBtn.isEnabled = true
        self.songEditorView!.songIsPlayingView.songEndedPlaying()
    }

    
    /*
     ===================================================================
     ============================= TOUCHES =============================
     */
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if let animal = node as? Animal {
                for anAnimal in self.animals {
                    anAnimal.isDragged = false
                }
                animal.isDragged = true
            }
        }
    }
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //touchMoved(toPoint: t.location(in: self))
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            
            if let _ = node as? Animal {
                
                for animal in animals {
                    if animal.isDragged {
                        animal.position = touch.location(in: self.stage) // update position
                        self.keepInStage(node: animal) // make sure animal won't leave the stage
                        self.updateAnimalOrder() // update the z-indices of the animals
                        animal.updateSize() // update the size of the animal
                    }
                }
            }
            
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            //let location = touch.location(in: self)
            //let node = self.atPoint(location)
            
            for animal in self.animals {
                animal.isDragged = false
            }
        }
    }
    
    /*
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
    
    
    private func keepInStage(node: SKSpriteNode) {
        let padding: CGFloat = self.stage.frame.height * 0.05
        let halfOfNode = (width: node.frame.width * 0.5, height: node.frame.height * 0.5)
        
        if node.frame.minX <= padding {
            node.position.x = padding + halfOfNode.width
        }
        if node.frame.maxX >= self.stage.frame.width - padding {
            node.position.x = self.stage.frame.width - padding - halfOfNode.width
        }
        if node.frame.minY <= padding {
            node.position.y = padding + halfOfNode.height
        }
        if node.frame.minY + node.frame.height * 0.2 >= self.stage.frame.height - padding {
            node.position.y = self.stage.frame.height - padding + node.frame.height * 0.2
        }
    }
    
    private func updateAnimalOrder() {
        self.animals = self.animals.sorted(by: { $0.position.y > $1.position.y })
        
        for i in 0..<self.animals.count {
            self.animals[i].zPosition = CGFloat(i)
        }
    }
    
    
    /*
     ===================================================================
     ============================ UI Logic =============================
     */
    
    /*private func songPickerButtonPushed() {
        print("song picker button pushed")
    }*/
    
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
        let wallTex = SKTexture(imageNamed: "room/wall.png")
        let wall = SKSpriteNode(color: UIColor.red, size: CGSize(width: frame.width, height: frame.height * 7 / 16))
        wall.position = CGPoint(x: 0.0, y: frame.height)
        wall.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        wall.zPosition = -91
        wall.texture = wallTex
        wall.texture?.filteringMode = .nearest
        
        self.addChild(wall)
    }
    
    private func addStage() {
        let stageTex = SKTexture(imageNamed: "room/stage.png")
        stage = SKSpriteNode(color: UIColor.brown, size: CGSize(width: frame.width, height: frame.height * 5 / 16))
        stage.position = CGPoint(x: 0.0, y: frame.height * 0.25)
        stage.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        stage.zPosition = -90
        stage.texture = stageTex
        stage.texture?.filteringMode = .nearest
        
        self.addChild(stage)
    }
    
    private func addGround() {
        let groundTex = SKTexture(imageNamed: "room/audience.png")
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
        // Piano Cat
        let animalPianoCat = Animal(type: "cat", sceneSize: frame.size)
        animalPianoCat.position = CGPoint(x: stage.frame.width * 0.3, y: stage.frame.height * 0.7)
        
        // Guitar Dog
        let animalGuitarDog = Animal(type: "dog", sceneSize: frame.size)
        animalGuitarDog.position = CGPoint(x: stage.frame.width * 0.8, y: stage.frame.height * 0.5)
        
        // Cello Turtle
        
        // Drum Frog
        
        stage.addChild(animalPianoCat)
        stage.addChild(animalGuitarDog)
        
        self.animals.append(animalPianoCat)
        self.animals.append(animalGuitarDog)
        
        animalPianoCat.updateSize()
        animalGuitarDog.updateSize()
        
        self.updateAnimalOrder()
    }
    
    
    private func addMenu() {
        let menuWidth = frame.width * 0.9
        let menuHeight = frame.height * 0.1
        let menuMargin = (frame.width - menuWidth) * 0.5
        let menu = SKSpriteNode(color: UIColor.clear, size: CGSize(width: menuWidth, height: menuHeight))
        menu.position = CGPoint(x: menuMargin, y: frame.height - menuMargin)
        menu.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        menu.zPosition = 100
        
        /* Pause Button */
        pauseBtn = SKButton(defaultButtonImage: "Menu/Pause_Button/pauseButton_default.png", activeButtonImage: "Menu/Pause_Button/pauseButton_active.png", buttonAction: pauseButtonPushed)
        pauseBtn.scaleTo(newHeight: menu.frame.height)
        pauseBtn.position = CGPoint(x: menu.frame.width, y: 0.0)
        pauseBtn.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        
        /* Play Button */
        playBtn = SKButton(defaultButtonImage: "Menu/Play_Button/playButton_default.png", activeButtonImage: "Menu/Play_Button/playButton_active.png", buttonAction: playButtonPushed)
        playBtn.scaleTo(newHeight: menu.frame.height)
        playBtn.position = CGPoint(x: pauseBtn.frame.minX - pauseBtn.frame.width * 0.5, y: 0.0)
        playBtn.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        
        
        menu.addChild(playBtn)
        menu.addChild(pauseBtn)
        
        self.addChild(menu)
    }
}

