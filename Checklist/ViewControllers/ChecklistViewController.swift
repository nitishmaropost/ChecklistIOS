//
//  ViewController.swift
//  Checklist
//
//  Created by Nitish on 19/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import UIKit
import Floaty

class ChecklistViewController: UIViewController, UIWebViewDelegate {
    
    // IBOutlets
    @IBOutlet weak var segmentChecklist: UISegmentedControl!
    @IBOutlet weak var buttonFloat: Floaty!
    @IBOutlet weak var viewContent: UIView!
    
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ChecklistTableViewController")
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ReminderTableViewController")
        
        return secondChildTabVC
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUISettings()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    func initialUISettings() {
        self.title = "Checklist"
        
        self.segmentChecklist.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Futura", size: 14)!],
                                                for: .normal)
        self.segmentChecklist.layer.masksToBounds = true
        self.segmentChecklist.layer.cornerRadius = 5
        self.segmentChecklist.layer.borderColor = UIColor.white.cgColor
        self.segmentChecklist.layer.borderWidth = 1
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap(recognizer:)))
        self.buttonFloat.addGestureRecognizer(tapGesture)
        self.buttonFloat.sticky = true
    }
    
    @objc func handleSingleTap(recognizer: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddChecklistViewController")
        let navController = UINavigationController(rootViewController: vc!)
        navController.navigationBar.barTintColor = self.navigationController?.navigationBar.barTintColor
        navController.navigationBar.tintColor = self.navigationController?.navigationBar.tintColor
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.isOpaque = true
        navController.navigationBar.barStyle = .black
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.segmentChecklist.tintColor = Constants.kColorViewChecklist
            self.buttonFloat.plusColor = Constants.kColorViewChecklist
            self.navigationController?.navigationBar.barTintColor = Constants.kColorViewChecklist
            self.buttonFloat.isHidden = false
        } else {
            self.segmentChecklist.tintColor = Constants.kColorViewReminders
            self.buttonFloat.plusColor = Constants.kColorViewReminders
            self.navigationController?.navigationBar.barTintColor = Constants.kColorViewReminders
            self.buttonFloat.isHidden = true
        }
        
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }

    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.viewContent.bounds
            self.viewContent.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
}

