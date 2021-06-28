//
//  IniciarSesionViewController.swift
//  ProyectoFinal
//
//  Created by Mac 09 on 6/27/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class holaViewController: UIViewController {
    @IBAction func ventanPrincipal(_ sender: Any) {
        performSegue(withIdentifier: "ventanaPirncipalSegue", sender: nil)
    }
    
    
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

}
