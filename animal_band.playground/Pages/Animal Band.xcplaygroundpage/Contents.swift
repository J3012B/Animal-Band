import PlaygroundSupport
import SpriteKit
/*:
 ## Animal Band
 ### WWDC 2018 Scholarship Application - Josef Büttgen
 Hi there,
 how awesome it is, that your animals can play different musical instruments!
 They joined together to form a band - and will play the songs you wish them to.
 Feel free and choose the titles you wanna listen to from the song editor by clicking on the 'folder' symbol.
 */
let audienceApplauses = true

/*:
 If you want to create your own song, you can add notes by double clicking on a field in the editor. When you finished you can click on the 'save' symbol. The song will be saved to your 'Shared Playground Data' folder and will be named by the following variable:
 
 */
let titleOfSongToSave = "my_song"



/* Window configuration */
let frameSize = CGSize(width: 700, height: 700)
PlaygroundSupport.PlaygroundPage.current.liveView = AnimalBandView(size: frameSize, audienceApplauses: audienceApplauses, willSaveTo: titleOfSongToSave)
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
