//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by spongebink on 2019/2/1.
//  Copyright © 2019 spongebink. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvs = segue.destination as? ConcentrationViewController {
                    cvs.theme = theme
                }
            }
        }
    }
}
