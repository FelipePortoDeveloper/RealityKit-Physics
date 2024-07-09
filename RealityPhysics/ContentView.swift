//
//  ContentView.swift
//  RealityPhysics
//
//  Created by Felipe Porto on 09/07/24.
//

import SwiftUI
import RealityKit
import ARKit

class ARViewCoordinator: NSObject, ARSessionDelegate {
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = view else {return}
        
        // Descobrindo a localização do toque
        
        let tapLocation = recognizer.location(in: view)
        
        // Descobrindo qual entidade está na localização do toqu
        
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            
            // Mudando a cor do objeto
            
            let material = SimpleMaterial(color: .orange, isMetallic: true)
            entity.model?.materials = [material]
            
            // Criando um corpo fisico para o objeto 
        
            entity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: .default, mode: .dynamic)
        }
        
    }
    
}

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Adicionando um reconhecedor de gestures a arView
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(ARViewCoordinator.handleTap)))
        
        // Criando um material
    
        let material = SimpleMaterial(color: .purple, isMetallic: true)
        
        // Criando um mesh
        
        let mesh = MeshResource.generateBox(size: 0.2, cornerRadius: 0.005)
        
        // Criando uma entidade
        
        let box = ModelEntity(mesh: mesh, materials: [material])
        
            // Adicionando colisões / fisica na caixa
        
        box.generateCollisionShapes(recursive: true)
        
        // Criando uma ancora
        
        let anchor = AnchorEntity(plane: .horizontal)
        
            // Mudando a posição da caixa no eixo y
        
        anchor.position = SIMD3<Float>(0, 1.0, 0)
        
        // Adicionando a caixa na ancora
        
        anchor.addChild(box)
        
        // Adicionando as configurações da view
        
        context.coordinator.view = arView
        arView.session.delegate = context.coordinator
        
        // Adicionando a ancora na cena
        
        arView.scene.anchors.append(anchor)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func makeCoordinator() -> ARViewCoordinator {
        ARViewCoordinator()
    }
    
}

#Preview {
    ContentView()
}
