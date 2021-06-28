//
//  ComprandoBiciViewController.swift
//  ProyectoFinal
//
//  Created by Mac 09 on 6/27/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class ComprandoBiciViewController: UIViewController {

    @IBOutlet weak var NombreBicicleta: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var PrecioBici: UILabel!
    @IBOutlet weak var Comprar: UIButton!
    var producto:Adultos? = nil
    var usuarios:[Usuario] = []
    var usuario = Usuario()
    
    func MostrarImagen(ruta:String) {
        if let url = URL(string: ruta){
            do{
                let data = try Data(contentsOf: url)
                self.imagen.image = UIImage(data: data)
            }catch let err{
                print("error: \(err)")
            }
        }
    }
    
    
    @IBAction func ComprarProducto(_ sender: Any) {
        let compra = ["Producto": NombreBicicleta.text, "Precio": PrecioBici.text]
        Database.database().reference().child("usuarios").child(Auth.auth().currentUser!.uid).child("compras").childByAutoId().setValue(compra)
        print("usuario\(usuario.uid)\(usuario.email)")
        
        let alerta = UIAlertController(title: "Compra Exitosa", message: "Su compra se Realizo correctamente. Gracias!", preferredStyle: .alert)
        let btnOk = UIAlertAction(title: "Aceptar", style: .default, handler: {(UIAlertAction) in
            
        })
        alerta.addAction(btnOk)
        self.present(alerta, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MostrarImagen(ruta: producto!.imagen)
        NombreBicicleta.text = producto?.nombre
        PrecioBici.text = producto?.precio
        Database.database().reference().child("usuarios").observe(DataEventType.childAdded, with: {(snapshot) in print(snapshot)
            self.usuario.email = (snapshot.value as! NSDictionary)["email" ] as! String
            self.usuario.uid = snapshot.key
            self.usuarios.append(self.usuario)
        })
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
	
