//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by spongebink on 2019/2/1.
//  Copyright © 2019 spongebink. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    let themes = [
        "Sports": ["🏊‍♀️", "🤾‍♂️", "🏓", "🎾", "🚙", "🥎", "🎽", "⚾️", "🏈", "🏉", "🏸", "🏹", "🏑", "🏄‍♂️", "🎱", "🎳", "⚽️"],
        "Animals": ["🦓", "🦒", "🦔", "", "🦖", "🦗", "🦝", "🦙", "🦛", "🦘", "🦡", "🦚", "🦢", "🦜", "🦞", "🏇", "🕊", "🕷", "🕸", "🐀", "🐁", "🐂", "🐃", "🐄", "🐅", "🐆"],
        "Faces": ["🙎‍♀️", "🤦‍♀️", "👯‍♀️", "🚶‍♀️", "💆‍♀️", "🙆‍♀️", "🙍‍♂️", "🙋‍♂️", "😮", "😵", "😶", "😸", "😹", "😬", "😴", "👶", "👶", "👵", "🐵"]
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewCortroller {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewCortroller: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
}
