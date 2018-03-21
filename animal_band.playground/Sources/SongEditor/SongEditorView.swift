import UIKit

public class SongEditorView: UIView {
    
    private var menuBar: UIView!
    private var body: UIView!
    
    private var currentInstrument: String!
    
    private let availableInstruments = ["piano", "guitar", "cello", "drums"]
    
    
    
    /*  INITIALIZATION  */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue
        
        self.addUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    private func instrumentPickerButtonPushed() {
        print("User clicked on the instrument picker button")
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
        let instrumentPicker = Picker(frame: instrumentPickerFrame, titles: instrumentPickerTitles, action: instrumentPickerButtonPushed)
        
        self.menuBar.addSubview(instrumentPicker)
        
    }
    
    /*  BODY  */
    
    private func addBody() {
        body = UIView(frame: CGRect(x: 0.0, y: menuBar.frame.maxY, width: frame.width, height: frame.height - menuBar.frame.height))
        body.backgroundColor = UIColor(hex: "ffffff")
        
        self.addSubview(body)
        
        self.addScaleView()
        self.addNoteField()
    }
    
    private func addScaleView() {
        let scaleView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: body.frame.width * 0.15, height: body.frame.height))
        scaleView.backgroundColor = UIColor.green
        
        body.addSubview(scaleView)
    }
    
    private func addNoteField() {
        let noteFieldFrame = CGRect(x: body.frame.width * 0.15, y: 0.0, width: body.frame.width * 0.85, height: body.frame.height)
        let noteField = UIScrollView(frame: noteFieldFrame)
        
        noteField.contentSize = CGSize(width: 500.0, height: 700.0)
        noteField.backgroundColor = UIColor.brown
        
        body.addSubview(noteField)
    }
}

