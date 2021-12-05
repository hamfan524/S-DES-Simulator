//
//  HelpViewController.swift
//  S-DES_program
//
//  Created by 최동호 on 2021/12/02.
//

import UIKit
import SafariServices

class HelpViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchUpToLinkToGithub(_ sender: UIButton) {
        
        let githubUrl = NSURL(string: "https://github.com/hamfan524/S-DES-Simulator")
        let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubUrl! as URL)
        self.present(githubSafariView, animated: true, completion: nil)
        
        
    }
}
