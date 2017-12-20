
import UIKit
import GameplayKit


class ViewController: UIViewController {

    var pokemonList = [String]()
    var score = 0
    var correctAnswer = 0
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Collect all resources from local filesystem.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let images = try! fm.contentsOfDirectory(atPath: path)
        
        // Accumulate reference to images in pokemonList.
        for image in images {
            if image.hasSuffix("png") {
                let imageTitle = image.replacingOccurrences(of: ".png", with: "", options: NSString.CompareOptions.literal, range: nil)
                pokemonList.append(imageTitle)
            }
        }
        askQuestion()
    }

    func askQuestion(_ action: UIAlertAction! = nil) {

        // Shuffle pokemonList so the first three indexes are truly random.
        pokemonList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: pokemonList) as! [String]
        // Assign (the now random) strings at index 1..2 to UIImage buttons.
        button1.setImage(UIImage(named: pokemonList[2]), for: UIControlState());
        button2.setImage(UIImage(named: pokemonList[1]), for: UIControlState());
        button3.setImage(UIImage(named: pokemonList[3]), for: UIControlState());


        
        // Generate random number to/Users/davidrobbins/galvanize/unit-4/practice/swift/swift-unfamiliar-environment/Pokemon/ViewController.swift reference the display title and correct index in pokemonList.
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        title = pokemonList[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "That's correct!"
            score += 1
        } else {
            title = "You Idiot!!!!"
            score -= 1
        }
        displayLabel.text = "Score: \(score)";

        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true, completion: nil)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

