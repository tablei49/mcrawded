//
//  Signin.swift
//  Crowd Management
//
//  Created by thr on 8/2/18.
//  Copyright © 2018 thr. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class Signin: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var ConfirmPassWord: UITextField!
 
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBAction func SingninButton(_ sender: AnyObject) {
        
        
        guard let Email = EmailTF.text?.trimmingCharacters(in: CharacterSet.whitespaces ), !Email.isEmpty
            else {ErrorLabel.text = "Email Is Empty"
                return}
        
        guard let PassWord = PasswordTF.text , !PassWord.isEmpty
            else {ErrorLabel.text = "PassWord Is Empty"
                return}
        
        guard let ConfirmPassWord = ConfirmPassWord.text , !ConfirmPassWord.isEmpty
            else {ErrorLabel.text = "ConfirmPassWord Is Empty"
                return}
        
        guard PassWord == ConfirmPassWord
            else{
                self.ErrorLabel.text = "Password Don't match"
                return }
        
        if Email != "" , PassWord != "" , ConfirmPassWord == PassWord {
            Auth.auth().signIn(withEmail: Email, password: PassWord , completion: { (user : User? , error : Error? ) in
                if  error == nil && user != nil
                {  print ("User creat")}
            })
            

        }//end SingninButton
            

                              
            /*
                else
                {
                    
                    let ref = Database.database().reference().child("Users")
                    let UserID = Auth.auth().currentUser?.uid
                    let SB = UIStoryboard(name: "Main", bundle: nil)
                    
                    Auth.auth().signIn(withEmail: Email, password: PassWord, completion: { (user, error) in
                        if let error = error
                        { self.ErrorLabel.text = ErrorLabel.Instance.TranslateError(WithErroeCode: (error._code))
                            
                            let Designer = SB.instantiateViewController(withIdentifier: "FreeLancerHomePage")
                            self.present( Designer , animated: true , completion: nil)
                        }
                      
         
                        }//End else*/
                    
            
            
        

        
}
}


