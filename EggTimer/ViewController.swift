import UIKit
import AVFoundation // Framework for audio media

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Initializing required variables and constants
    let eggTimes = ["Soft": 240, "Medium": 360, "Hardtime": 540]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    // Hiding progress bar after view loaded
    override func viewDidLoad()
    {
        hideProgressBar()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        let hardness = sender.currentTitle! // Writing choosen hardness into a variable

        resultLabel.text = hardness // Showing choosen hardness on the screen

        // Reseting progress bar, timer and seconds that passed
        progressBar.progress = 0
        resetAll()
        
        if eggTimes[hardness] != nil {
            totalTime = eggTimes[hardness]!
        } // Checking value from eggTimes dictionary to unwrap it
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true) // Initializing timer with 1 second interval and calling function updateTimer
        
        showProgressBar() // Unhiding progress bar after hardness was selected and timer launched
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime) // Calculating percentage
        } else {
            resetAll() // After timer finished reseting it and variable with seconds that passed
            resultLabel.text = "Done!"
            playSound()
        }
        
    }
    
    func resetAll() {
        timer.invalidate()
        secondsPassed = 0
    }
    
    func hideProgressBar() {
        progressBar.isHidden = true
    }
    
    func showProgressBar() {
        progressBar.isHidden = false
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") // Reading file with alarm
        player = try! AVAudioPlayer(contentsOf: url!) // Assigning audio player with url to our file
        player.play() // Launching sound
    }
}
