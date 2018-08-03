//
//  ViewController.swift
//  Crowd Management
//
//  Created by thr on 8/2/18.
//  Copyright © 2018 thr. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class ViewController: UIViewController {
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func loginButton(_ sender: AnyObject) {
       
        
        guard let Email = EmailTF.text?.trimmingCharacters(in: CharacterSet.whitespaces ), !Email.isEmpty
            else {ErrorLabel.text = "Email Is Empty"
                return}
        
        guard let PassWord = PasswordTF.text , !PassWord.isEmpty
            else {ErrorLabel.text = "PassWord Is Empty"
                return}
        
        
        if  let Email =  EmailTF.text , Email != "" , let Password = PasswordTF.text , Password != "" {
            
            Auth.auth().signIn(withEmail: Email, password: Password , completion: { (user : User? , error : Error? ) in
                
                if let  error = error
                {  print (error.localizedDescription)}
                
                else{
                    if let  user = user
                    {  print (user)}
                    
                    
            
            
            
                    let SB = UIStoryboard(name: "Home", bundle: nil)
                    
                    let ref = Database.database().reference().child("Users")
                    let UserID = Auth.auth().currentUser?.uid
                    
                    //ref.child(UserID!).queryOrdered(byChild: "User Type").observe(.value, with: { snapshot in
                    
                    ref.child(UserID!).observe(.value) { (snapshot : DataSnapshot) in
                        // if !snapshot.exists() { return }
                        let  Dic =  snapshot.value as? Dictionary <String,AnyObject>
                        let UserType = Dic?["User Type"] as? Int
                        
                        // let  UserType =  snapshot.value!["User Type"] as? [ Int: Any]
                        
                        
                        // go to OWner
                        if UserType == 0
                        {
                            let OWner = SB.instantiateViewController(withIdentifier: "OwnerHomPage")
                            self.present( OWner , animated: true , completion: nil)
                        }
                        //Go To FreeLancerHomePage
                        if UserType == 1
                        {
                            let FreeLancer = SB.instantiateViewController(withIdentifier: "FreeLancerHomePage")
                            self.present( FreeLancer , animated: true , completion: nil)
                        }
                        
                    }
                    
                    
                }
                
            })
            
            
        }
    }/// End Log_In Button
    
    func KeyBoredSiting() {
        NotificationCenter.default.addObserver(self , selector: #selector(showKeybord) , name: NSNotification.Name.UIKeyboardWillShow , object: nil)
        
        NotificationCenter.default.addObserver(self , selector: #selector(HideKeybord) , name: NSNotification.Name.UIKeyboardWillHide , object: nil)
    }
    
    func showKeybord(sender : NSNotification){
        //let userinfo : NSDictionary = sender.userInfo! as NSDictionary
        // let keybordfarmat : NSValue = userinfo.value(forKeyPath: UIKeyboardFrameEndUserInfoKey) as! NSValue
        // let keybordrect = keybordfarmat.cgRectValue
        // let heybordH = keybordrect.height
        
        
        // self.view.frame = CGRect (origin: CGPoint(x: 0,y : -heybordH), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height))
    }
    
    func HideKeybord(sender : NSNotification)
    {
        //  self.view.frame = CGRect (origin: CGPoint(x: 0,y : 0), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height))
        
        print("Hide")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    


    }





