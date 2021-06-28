//
//  ComprasViewController.swift
//  ProyectoFinal
//
//  Created by Mac 09 on 6/27/21.
//  Copyright © 2021 Mac 09. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class ComprasViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablaCompras: UITableView!
    var productos:[Producto] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let product = productos[indexPath.row]
        cell.textLabel?.text = product.Producto
        cell.detailTextLabel?.text = product.Precio
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaCompras.delegate = self
        tablaCompras.dataSource = self
        Database.database().reference().child("usuarios").child(Auth.auth().currentUser!.uid).child("compras").observe(DataEventType.childAdded, with: {(snap) in print("este es el snapppp:\(snap)")
            let producto = Producto()
            print("valor:\((snap.value as! NSDictionary)["Precio"] as! String)")
            producto.Producto = (snap.value as! NSDictionary)["Producto"] as! String
            producto.Precio = (snap.value as! NSDictionary)["Precio"] as! String
            
            self.productos.append(producto)
            self.tablaCompras.reloadData()
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
