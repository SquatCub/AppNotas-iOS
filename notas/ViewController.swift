//
//  ViewController.swift
//  notas
//
//  Created by Brandon Rodriguez Molina on 12/04/21.
//

import UIKit

class ViewController: UIViewController {
    // Base de datos "local"
    var defaultsBD = UserDefaults.standard
    // Arreglo de notas
    var notas = [""]
    // Arreglo de fechas
    var fechas = [""]
    
    // Nota auxiliar para segue
    var currentNota: String?
    // Fecha auxiliar para segue
    var currentFecha: String?
    // INdex auxiliar para segue
    var currentIndex: Int?
    // Tabla
    @IBOutlet weak var tablaNotas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Asignar delegado y dataSourse a la tabla
        tablaNotas.backgroundColor = UIColor.clear
        tablaNotas.delegate = self
        tablaNotas.dataSource = self
        // Si ya hay algo en la BD lo obtiene, sino muestra la lista vacia
        if let arregloBD = defaultsBD.array(forKey: "notas") as? [String] {
            notas = arregloBD
        } else {
            notas = []
        }
        if let arregloBD = defaultsBD.array(forKey: "fechas") as? [String] {
            fechas = arregloBD
        } else {
            fechas = []
        }
    }
    // Funcion para checar si hay cambios y aplicarlos
    override func viewWillAppear(_ animated: Bool) {
        if let notasEditadas = defaultsBD.array(forKey: "notas") as? [String] {
            notas = notasEditadas
        }
        tablaNotas.reloadData()
    }
    // Funcion para agregar nota nueva
    @IBAction func crearNota(_ sender: Any) {
        // Creacion de la alerta
        let alerta = UIAlertController(title: "Agregar nota", message: "", preferredStyle: .alert)
        // Creamos un textField para la alerta
        var notaTextField = UITextField()
        // Se agrega el textField a la alerta
        alerta.addTextField { (agregarNotaAction) in
            agregarNotaAction.placeholder = "Escribe aqui"
            notaTextField = agregarNotaAction
        }
        // Acciones para cuando se muestra la alerta
        let accionAceptar = UIAlertAction(title: "Ok", style: .default) { (_) in
            // GUardar notas
            guard let nuevaNota = notaTextField.text else { return }
            self.notas.append(nuevaNota)
            self.defaultsBD.set(self.notas, forKey: "notas")
            // GUardar fechas
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .short

            let datetime = formatter.string(from: now)
            self.fechas.append(datetime)
            self.tablaNotas.reloadData()
            self.defaultsBD.set(self.fechas, forKey: "fechas")
        }
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        // Se agregan a la alerta
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        // Mostrar la alerta con animacion
        present(alerta, animated: true, completion: nil)
    }
}
// Table view methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // Mostrar solo el numero de datos existente de datos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    // Asignar cada valor a su celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNotas.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = notas[indexPath.row]
        
        let fecha = "Fecha: "+fechas[indexPath.row]
        celda.detailTextLabel?.text = fecha
        celda.textLabel?.textColor = UIColor.white
        
        return celda
    }
    // Poder ejecutar accion al hacer click en un elemento
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentNota = notas[indexPath.row]
        currentFecha = fechas[indexPath.row]
        currentIndex = Int(indexPath.row)
        performSegue(withIdentifier: "editar", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            let objetoEditar = segue.destination as! EditarViewController
            objetoEditar.nota = currentNota
            objetoEditar.fecha = currentFecha
            objetoEditar.index = currentIndex
            objetoEditar.notas = self.notas
        }
    }
    // FUncion para eliminar notas
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notas.remove(at: indexPath.row)
            fechas.remove(at: indexPath.row)
            tablaNotas.deleteRows(at: [indexPath], with: .fade)
            defaultsBD.set(notas, forKey: "notas")
            defaultsBD.set(fechas, forKey: "fechas")
        }
    }
    // Agregar espacio entre celdas
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 5
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
}

