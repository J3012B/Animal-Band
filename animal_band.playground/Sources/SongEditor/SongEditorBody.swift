import UIKit

public class SongEditorBody: UIView, UIScrollViewDelegate {
    
    private var scaleView: UIScrollView! // shows the pitch
    private var barView: UIScrollView! // shows the bars
    private var noteField: UIScrollView! // shows the actual notes
    
    private var songName: String!
    private var instrument: String!
    private var range: Int!
    private var songLength: Int!

    private let notes = ["C", "C#", "D", "D#", "E", "F", "G", "G#", "A", "A#", "B"]
    
    
    /*  INITIALIZATION  */
    
    public init(frame: CGRect, songName: String, instrument: String) {
        super.init(frame: frame)
                
        self.songName = songName
        self.instrument = instrument
        
        self.addUI()
        self.reload(songName: self.songName, instrument: self.instrument)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func getRangeOf(instrument: String) -> Int {
        let ranges = ["Piano" : 66, "Guitar" : 10, "Cello" : 2, "Drums" : 30]
        let range: Int = ranges[self.instrument]!
        
        return range
    }
    
    private func getBarCount() -> Int {
        return 32
    }
    
    /*
     ===================================================================
     ========================== Scroll View ============================
     */
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.noteField {
            self.scaleView.contentOffset = CGPoint(x: 0.0, y: noteField.contentOffset.y)
            self.barView.contentOffset = CGPoint(x: noteField.contentOffset.x, y: 0.0)
        } else if scrollView == self.scaleView {
            self.noteField.contentOffset = CGPoint(x: noteField.contentOffset.x, y: scaleView.contentOffset.y)
        } else if scrollView == self.barView {
            self.noteField.contentOffset = CGPoint(x: barView.contentOffset.x, y: noteField.contentOffset.y)
        }
    }
    
    /*
     ===================================================================
     ============================= Reload ==============================
     */
    
    public func reload(songName: String, instrument: String) {
        self.instrument = instrument
        self.songName = songName
        self.range = getRangeOf(instrument: instrument)
        self.songLength = getBarCount() * 4
        
        self.reloadNoteField()
        self.reloadScaleView()
        self.reloadBarView()
    }
    
    private func reloadNoteField() {
        // remove all subviews, which - in this case - are the note views
        self.noteField.subviews.forEach({ $0.removeFromSuperview() })
        
        // set size of note view
        let noteViewHeight: CGFloat = self.noteField.frame.height * 0.1
        let noteViewWidth: CGFloat = self.noteField.frame.width * 0.05
        
        // create note views and add them to the note field
        for j in 0..<self.songLength {
            for i in 0..<self.range {
                let noteViewFrame = CGRect(x: CGFloat(j) * noteViewWidth, y: CGFloat(i) * noteViewHeight, width: noteViewWidth, height: noteViewHeight)
                let noteView = NoteView(frame: noteViewFrame)
                
                noteView.layer.borderWidth = 1
                noteView.layer.borderColor = UIColor(hex: "#808B96").cgColor
                
                self.noteField.addSubview(noteView)
            }
        }
        
        // resize the note field based on its content
        self.noteField.contentSize = CGSize(width: noteViewWidth * CGFloat(self.songLength), height: noteViewHeight * CGFloat(self.range))
    }
    
    private func reloadScaleView() {
        // remove all subviews, which - in this case - are the scale labels
        self.scaleView.subviews.forEach({ $0.removeFromSuperview() })
        
        // set height of note view
        let scaleLblHeight: CGFloat = self.noteField.frame.height * 0.1
        
        for i in 0..<range {
            let scaleLblFrame = CGRect(x: 0.0, y: CGFloat(i) * scaleLblHeight, width: scaleView.frame.width, height: scaleLblHeight)
            let scaleLbl = UILabel(frame: scaleLblFrame)
            
            scaleLbl.backgroundColor = UIColor(hex: "#D5D8DC")
            scaleLbl.layer.borderColor = UIColor(hex: "#808B96").cgColor
            scaleLbl.layer.borderWidth = 1
            scaleLbl.textAlignment = .center
            
            let noteIndex = self.notes.count - 1 - (i % self.notes.count)
            scaleLbl.text = "\(self.notes[noteIndex])"
            scaleLbl.textColor = UIColor(hex: "#1C2833")
            scaleLbl.font = scaleLbl.font.withSize(scaleLbl.frame.height * 0.8)
            
            self.scaleView.addSubview(scaleLbl)
        }
        
        // resize the note field based on its content
        self.scaleView.contentSize = CGSize(width: scaleView.frame.width, height: scaleLblHeight * CGFloat(range))
    }
    
    private func reloadBarView() {
        // remove all subviewsall
        self.barView.subviews.forEach({ $0.removeFromSuperview() })
        
        // set width of noteview
        let barLblWidth: CGFloat = self.noteField.frame.width * 0.05 * 4
        
        for i in 0..<self.getBarCount() {
            let barLblFrame = CGRect(x: CGFloat(i) * barLblWidth, y: 0.0, width: barLblWidth, height: barView.frame.height)
            let barLbl = UILabel(frame: barLblFrame)
            
            barLbl.backgroundColor = UIColor(hex: "#D5D8DC")
            barLbl.layer.borderColor = UIColor(hex: "#808B96").cgColor
            barLbl.layer.borderWidth = 1
            barLbl.textAlignment = .left
            
            let currentBar = fits(number: 4, into: i) + 1
            let currentBeat = (i % 4) + 1
            barLbl.text = "\(currentBar).\(currentBeat)"
            barLbl.textColor = UIColor(hex: "#1C2833")
            barLbl.font = barLbl.font.withSize(barLbl.frame.height * 0.8)
            
            self.barView.addSubview(barLbl)
        }
        
        // resize the bar view based on its content
        self.barView.contentSize = CGSize(width: CGFloat(self.songLength) * barLblWidth, height: barView.frame.height)
    }
    
    private func fits(number num1: Int, into num2: Int) -> Int {
        var currentNum = abs(num1)
        var counter = 0
        
        while currentNum <= abs(num2) {
            currentNum += abs(num1)
            counter += 1
        }
        
        return counter
    }
    
    
 
    
    /*
     ===================================================================
     ========================= User Interface ==========================
     */
    
    private func addUI() {
        self.addScaleView()
        self.addBarView()
        self.addNoteField()
    }
    
    private func addScaleView() {
        scaleView = UIScrollView(frame: CGRect(x: 0.0, y: frame.height * 0.1, width: self.frame.width * 0.15, height: self.frame.height * 0.9))
        
        scaleView.contentSize = CGSize(width: 200.0, height: 500.0)
        scaleView.bounces = false
        scaleView.hideIndicators()
        scaleView.backgroundColor = UIColor(hex: "#2C3E50")
        scaleView.delegate = self
        
        self.addSubview(scaleView)
    }
    
    private func addBarView() {
        barView = UIScrollView(frame: CGRect(x: scaleView.frame.maxX, y: 0.0, width: frame.width - scaleView.frame.width, height: frame.height * 0.1))
        
        barView.bounces = false
        barView.hideIndicators()
        barView.backgroundColor = UIColor.lightGray
        barView.delegate = self
        
        self.addSubview(barView)
    }
    
    private func addNoteField() {
        let noteFieldFrame = CGRect(x: barView.frame.minX, y: barView.frame.maxY, width: barView.frame.width, height: frame.height - barView.frame.height)
        
        noteField = UIScrollView(frame: noteFieldFrame)
        noteField.contentSize = CGSize(width: 500.0, height: 700.0)
        noteField.bounces = false
        noteField.indicatorStyle = .white
        noteField.backgroundColor = UIColor(hex: "#ABB2B9")
        noteField.delegate = self
        
        self.addSubview(noteField)
    }
    
    
}

