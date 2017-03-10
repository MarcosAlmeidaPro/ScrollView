//
//  ViewController.swift
//  ScrollView
//
//  Created by MK3 on 08/11/16.
//  Copyright © 2016 Nest Code. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var images = [UIImageView]()
    var currentPage = 0
    let maxPage = 2
    let minPage = 0
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.alpha = 0.0
        self.view.frame = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
       
    }
    
  
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2.0){
            
            //self.view.alpha = 1.0
            self.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
          
        }
        
        
        //Variável que definirá o tamanho Width do scrollView
        
        var contentWidth:CGFloat = 0.0
        
        // Este loop adiciona três imagens em nossa scrollView, além de criá-las e definir os seus tamanhos.
        
        for x in 0...2 {
            let image = UIImage(named: "icon\(x).png")
            let imageView = UIImageView(image: image)
            images.append(imageView)
            
            var newX: CGFloat = 0.0
            
            //Define a largura da scrollView.
            
            newX = scrollView.frame.size.width / 2 + scrollView.frame.size.width * CGFloat(x)
            
            //Soma as larguras do newX, para definir a largura total da scrollview.
            
            contentWidth += scrollView.frame.size.width * CGFloat(x)
            
            // Inclui a imagem dentro do scrollView
            
            scrollView.addSubview(imageView)
            
            
            // Define o tamanho que a imagem terá dentro do scrollView. O X define a posição horizontal do elemento, sendo 0 localizado no canto esquerdo superior. Definimos o X como a variável newX - 75, posicionando o elemento no centro da tela (horizontal). O Y define a posição vertical do elemento. Neste caso definimos o posicionamento como sendo a metade da altura do scrollView. Como o posicionamento posiciona a imagem na metade da tela, pelo canto superior esquerdo, precisamos subtrair metade do tamanho do frame da imagem, para que a imagem fique centralizada no scrollView.
            
            imageView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
            
            
            // Modifica o tamanho original da imagem selecionada.
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
            
        }
        
        // Define a largura total da scrollView e a altura.
        
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
        
        // Clips to bounds funciona como uma máscara de conteúdo, permitindo ou não a visualização do restante do conteúdo, que está delimitado fora do limite da scrollview visualizada.
        
        scrollView.clipsToBounds = false
        
        
    }

    // Foram criados dois Gestures (direita e Esquerda) e alterado o modo para UISwipeGestureRecognizer, para que o sistema entenda qual dos lados está sendo acionado. Nesta ação foi associada a função moveScroll, onde é atribuído um valor adicional para a current page. Para que os gestures fucione perfeitamente, precisamos desabilitar  a opção Scrolling Enabled na StoryBoard.
    
    @IBAction func swipePages(_ sender: UISwipeGestureRecognizer) {
        
        if (currentPage < maxPage && sender.direction == UISwipeGestureRecognizerDirection.left) {
            moveScroll(direction: 1)
            
        }
        
        if (currentPage > minPage && sender.direction == UISwipeGestureRecognizerDirection.right) {
            moveScroll(direction: -1)
           
        }
        
        
    }
    
    // Esta função define o ponto que deverá ser mostrado na ScrollView, levando em consideração a currentPage. Ela também altera o tamanho da imagem mostrada na currentPage e ao mesmo tempo retorna ao valor original as demais imageviews.
    
    func moveScroll (direction: Int){
        currentPage = currentPage + direction
        let point = CGPoint(x: scrollView.frame.size.width * CGFloat(currentPage), y: 0.0)
        scrollView.setContentOffset(point, animated: true)
        
        UIView.animate(withDuration: 0.4){
            self.images[self.currentPage].transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
            
        
            for x in 0...2{
                
                if (x != self.currentPage) {
                    self.images[x].transform = CGAffineTransform.identity
                }
            }

            
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

