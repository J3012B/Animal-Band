import Foundation

public struct Song {
    public var tempo = 100
    public var beats = 4
    public var rythm = 4
    public var instruments = [String: [Note]]()
    public var length = 0
    
    public init() {
        self.tempo = 100
        self.beats = 4
        self.rythm = 4
        self.instruments = [String : [Note]]()
    }
    
    public init(filePath: String) {
        if let path = Bundle.main.path(forResource: filePath, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                //print("Song.init >> will try to serialize json")
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //print("Song.init >> did try to serialize json")
                if  let song = jsonResult as? Dictionary<String, AnyObject>,
                    let info = song["info"] as? [String: Int],
                    let instruments = song["instruments"] as? [String : [[String: Any]]]  {
                    
                    self.tempo = info["tempo"]!
                    self.beats = info["beats"]!
                    self.rythm = info["tempo"]!
                    
                    //print("Count of instruments is \(instruments.count)")
                    
                    for (instrument, notes) in instruments {
                        //print(instrument + " plays the following notes:")
                        
                        if notes.count == 0 {
                            self.instruments[instrument] = [Note]()
                        }
                        
                        for note in notes {
                            let pitch = note["pitch"] as! String
                            let octave = note["octave"] as! Int
                            let time = note["time"] as! Int
                            
                            let newNote = Note(pitch: pitch, octave: octave, time: time)
                            
                            //print("Add new note to '\(instrument)': \(newNote.pitch!)\(newNote.octave!) at \(newNote.time!)")
                            
                            if self.instruments[instrument] == nil {
                                self.instruments[instrument] = [Note]()
                            }
                            self.instruments[instrument]! += [newNote]
                            
                            if time > length {
                                self.length = time
                            }
                        }
                    }
                    
                    self.length += 8
                    
                } else {
                    print("Song.init >> Could not load song from json")
                    self.tempo = 100
                    self.beats = 4
                    self.rythm = 4
                    self.instruments = [String : [Note]]()
                    self.length = 0
                }
            } catch {
                print("Sing.init >> Could not prepare song instructions for '\(filePath)'")
                self.tempo = 100
                self.beats = 4
                self.rythm = 4
                self.instruments = [String : [Note]]()
                self.length = 0
            }
        } else {
            print("Song.init >> Couldn't find file path for song")
        }
    }
    
    /*private mutating func fill() {
        self.tempo = 100
        self.beats = 4
        self.rythm = 4
        self.instruments = [String : [Note]]()
    }*/
}

/*
    SAMPLE JSON
 
{
    "info": {
        "tempo": 100,
        "beats": 4,
        "rythm": 4
    },
    "instruments": {
        "piano": [
        {
        "pitch": "c",
        "octave": 4,
        "time": 0
        },
        {
        "pitch": "d",
        "octave": 4,
        "time": 4
        },
        {
        "pitch": "e",
        "octave": 4,
        "time": 8
        },
        {
        "pitch": "f",
        "octave": 4,
        "time": 12
        },
        {
        "pitch": "g",
        "octave": 4,
        "time": 16
        },
        {
        "pitch": "g",
        "octave": 4,
        "time": 24
        }
        ],
        "guitar": [
        
        ],
        "drums": [
        
        ],
        "cello": [
        
        ]
    }
}
 */

