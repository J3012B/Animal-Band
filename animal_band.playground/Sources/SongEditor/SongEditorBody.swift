import UIKit

public class SongEditorBody: UIView, UIScrollViewDelegate {
    
    private var scaleView: UIScrollView! // shows the pitch
    private var barView: UIScrollView! // shows the bars
    private var noteField: NoteField! // shows the actual notes
    
    private var songObject: Song!
    private var instrument: String! // instrument pattern shown
    private var range: Int! // range of instrument
    private var songLength: Int! // length of the song

    private let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    private let notesUgly = ["c", "c_s_", "d", "d_s_", "e", "f", "f_s_", "g", "g_s_", "a", "a_s_", "b"]
    private let octaveMaxDict = ["Piano": 6, "Guitar": 3, "Drums": 0, "Cello": 0] // TODO: fill 'drums' and 'cello' with proper values
    private let ranges = ["Piano" : 72, "Guitar" : 44, "Cello" : 2, "Drums" : 30]
    
    
    /*  INITIALIZATION  */
    
    public init(frame: CGRect, instrument: String) {
        super.init(frame: frame)
                
        self.instrument = instrument
        self.songObject = Song(filePath: "songs/" + currentSong)
        
        self.addUI()
        self.reload(instrument: self.instrument)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
    private func getRangeOf(instrument: String) -> Int {
        let range: Int = self.ranges[self.instrument]!
        
        return range
    }
    
    private func getBarCount() -> Int {
        var latestBeat = 0
        var barCount = 0
        
        for (_, notes) in self.songObject.instruments {
            for note in notes {
                if note.time > latestBeat {
                    latestBeat = note.time
                }
            }
        }
        
        barCount = fits(number: 16, into: latestBeat) + 1
        
        return barCount
    }
    
    // returns a note object created using the position in the instrument's range counting from above (begins with 0)
    private func getNote(position: Int, instrument: String, time: Int) -> Note {
        let pitch = self.notesUgly[self.notes.count - 1 - (position % self.notes.count)]
        
        let octave = self.octaveMaxDict[instrument]! - fits(number: self.notes.count, into: position)
        
        return Note(pitch: pitch, octave: octave, time: time)
    }
    
    //
    private func getPosition(note: Note) -> Int {
        let positionOfToneInScale = Int(self.notesUgly.index(of: note.pitch)!) // position of 'c_s_' f.i.
        let positionInToneScale = (self.octaveMaxDict[self.instrument]! - note.octave + 1) * self.notesUgly.count - positionOfToneInScale
        let position = note.time * self.range + positionInToneScale
        
        //print("SongEditorBody.getPosition >> the position of the note \(note) is \(position)")
        
        return position
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
    
    public func reload(instrument: String) {
        self.instrument = instrument
        self.range = getRangeOf(instrument: instrument)
        self.songLength = getBarCount() * 16
        self.songObject = Song(filePath: "songs/" + currentSong)
        
        self.reloadNoteField()
        self.reloadScaleView()
        self.reloadBarView()
        
        self.loadNotes()
    }
    
    private func reloadNoteField() {
        // remove all subviews, which - in this case - are the note views
        self.noteField.subviews.forEach({ $0.removeFromSuperview() })
        self.noteField.noteViews = []
        
        // set size of note view
        let noteViewHeight: CGFloat = self.noteField.frame.height * 0.1
        let noteViewWidth: CGFloat = self.noteField.frame.width * 0.05
        
        // create note views and add them to the note field
        for j in 0..<self.songLength {
            for i in 0..<self.range {
                let noteViewFrame = CGRect(x: CGFloat(j) * noteViewWidth, y: CGFloat(i) * noteViewHeight, width: noteViewWidth, height: noteViewHeight)
                let noteView = NoteView(frame: noteViewFrame)
                noteView.note = getNote(position: i, instrument: self.instrument, time: j)
                
                //print("SongEditorBody.reloadNoteField >> Added note \(noteView.note) to note view")
                
                self.noteField.noteViews.append(noteView)
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
        
        for i in 0..<self.songLength {
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
    
    private func loadNotes() {
        let noteList = self.songObject.instruments[self.instrument!.lowercased()]
                
        if noteList != nil {
            for note in noteList! {
                let noteIndex = getPosition(note: note)
                self.noteField.noteViews[noteIndex].isSelected = true
            }
            print("SongEditorBody.loadNotes >> did load notes")
        } else {
            print("*** SongEditorBody.loadNotes >> Couldn't load notes with instrument '\(self.instrument!)'")
        }
        
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
        
        noteField = NoteField(frame: noteFieldFrame)
        noteField.delegate = self
        
        self.addSubview(noteField)
    }
    
    
}

