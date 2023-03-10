//
//  NotesTableViewCell.swift
//  Notes
//
//  Created by mac on 22.12.22.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerAction: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var imageViewAction: UIImageView!
    var date: String?
    var clickDeleteRow: (() -> ())?
    var clickEditRow: (() -> ())?
    var images: [UIImage] = []
    lazy var animationDuration = {
        return Double(images.count) / 18.0
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animationImage()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_ :)))
        panGesture.delegate = self
        containerView.addGestureRecognizer(panGesture)
        containerView.layer.cornerRadius = 20
        containerAction.layer.cornerRadius = 20
        imageViewAction.layer.cornerRadius = 20
        
    }
    
    private func animationImage() {
        for i in 0...47 {
            if let image = UIImage(named: "n_\(i)") {
                images.append(image)
            }
        }
        imageViewAction.animationImages = images
        imageViewAction.animationRepeatCount = 100
        imageViewAction.animationDuration = animationDuration
        imageViewAction.startAnimating()
    }
    
    @objc private func panGestureAction(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let translation = sender.translation(in: containerView)
            sender.setTranslation(.zero, in: containerView)
            guard translation.x < 0 || containerView.frame.origin.x < 0 else { return }
            containerView.frame.origin.x += translation.x
            imageViewAction.startAnimating()
        case .cancelled, .ended, .failed:
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                if self.containerView.frame.origin.x < -self.containerAction.bounds.width {
                    self.containerView.frame.origin.x = -self.containerAction.bounds.width
                } else {
                    if self.containerView.frame.origin.x > 0 {
                        self.containerView.frame.origin.x = 0
                    } else {
                        if abs(self.containerView.frame.origin.x) > (self.containerAction.bounds.width/2) {
                            self.containerView.frame.origin.x = -self.containerAction.bounds.width
                        } else {
                            self.containerView.frame.origin.x = 0
                        }
                    }
                }
            }
        default: break
        }
    }
    
    func getNoteDB(with note: Note) {
        let color: UIColor = .red
        let colorEncode = color.encode()
        let font: UIFont = .systemFont(ofSize: 17)
        let fontEncode = font.encode()
        labelHeader.text = note.header
        date = note.date
        labelDate.text = date
        labelNote.text = note.note
        labelNote.textColor = UIColor.color(data: (note.color ?? colorEncode)!)
        labelNote.font = UIFont.font(data: (note.font ?? fontEncode)!)
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func buttonEdit(_ sender: UIButton) {
        clickEditRow?()
    }
    
    @IBAction func clickButtonDelete(_ sender: UIButton) {
        CoreDataManager.shared.cleareDBbyDate(date: date ?? "")
       
        clickDeleteRow?()
    }
}
