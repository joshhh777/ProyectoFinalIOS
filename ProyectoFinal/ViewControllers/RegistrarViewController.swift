//
//  RegistrarViewController.swift
//  ProyectoFinal
//
//  Created by Mac 09 on 6/27/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class RegistrarViewController: UIViewController {

    
    @IBOutlet weak var TextoUsuario: UITextField!
    @IBOutlet weak var TextoContraseña: UITextField!
    
    @IBAction func Registrarse(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.TextoUsuario.text!, password: self.TextoContraseña.text!, completion: { (user, error) in
            print("Intentando Registrar un usuario")
            if error != nil{
                print("Se presento el siguiente error al Regitrar el usuario: \(error)")
            }else{
                print("El usuario fue creado exitosamente")
             Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                let alerta = UIAlertController(title: "Registro de Usuario", message: "Usuario: \(self.TextoUsuario.text!) se Registro correctamente", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Aceptar", style: .default, handler: {(UIAlertAction) in
                    self.performSegue(withIdentifier: "registroCompleto", sender: nil)
                })
                alerta.addAction(btnOk)
                self.present(alerta, animated: true, completion: nil)
            }
        })
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
