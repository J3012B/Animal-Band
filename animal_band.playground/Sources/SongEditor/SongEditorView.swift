import UIKit

public class SongEditorView: UIView {
    
    private var menuBar: UIView!
    private var instrumentPicker: Picker!
    private var body: SongEditorBody!
    
    private var currentInstrument: String = "Piano"
    private var currentSong: String!
    private var songLength: Int = 0
    
    
    
    
    /*  INITIALIZATION  */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hex: "#2C3E50")
        self.currentSong = "songs/alle_meine_entchen.json"
        
        self.addUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    
    private func instrumentPickerButtonPushed() {
        self.currentInstrument = self.instrumentPicker.currentTitle
        self.body.reload(songName: self.currentSong, instrument: currentInstrument)
    }
    
    /*
     ===================================================================
     ========================= User Interface ==========================
     */
    
    private func addUI() {
        self.addMenuBar()
        self.addBody()
    }
    
    /*  MENU BAR  */
    
    private func addMenuBar() {
        
        /* Add actual menu bar */
        let menuBarFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height * 0.2)
        menuBar = UIView(frame: menuBarFrame)
        
        menuBar.backgroundColor = UIColor(hex: "#566573")
        
        self.addSubview(menuBar)
        
        /* Add Children */
        
        let padding: CGFloat = 0.2 * menuBar.frame.height
        
        /* Add Instrument Picker */
        let instrumentPickerFrame = CGRect(x: padding, y: padding, width: frame.width * 0.3, height: menuBar.frame.height - 2 * padding)
        let instrumentPickerTitles = ["Piano", "Guitar", "Cello", "Drums"]
        instrumentPicker = Picker(frame: instrumentPickerFrame, titles: instrumentPickerTitles, action: instrumentPickerButtonPushed)
        
        self.menuBar.addSubview(instrumentPicker)
        
    }
    
    /*  BODY  */
    
    private func addBody() {
        let bodyFrame = CGRect(x: 0.0, y: menuBar.frame.maxY, width: frame.width, height: frame.height - menuBar.frame.height)
        
        print("Will init body with '\(currentSong!)' and '\(currentInstrument)'")
        
        body = SongEditorBody(frame: bodyFrame, songName: self.currentSong!, instrument: self.currentInstrument)
        
        self.addSubview(body)
    }
    
    
}

