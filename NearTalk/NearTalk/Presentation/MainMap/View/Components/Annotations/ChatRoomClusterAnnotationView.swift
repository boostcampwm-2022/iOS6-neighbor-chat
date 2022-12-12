//
//  ClusterChatRoomnAnnotationView.swift
//  NearTalk
//
//  Created by lymchgmk on 2022/11/15.
//

import MapKit

final class ChatRoomClusterAnnotationView: MKAnnotationView {
    static let reuseIdentifier = String(describing: ChatRoomClusterAnnotationView.self)
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.collisionMode = .circle
        self.centerOffset = CGPoint(x: 0, y: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ClusterChatRoomAnnotationView coder init 에러")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        if let clusterAnnotation = annotation as? MKClusterAnnotation {
            let totalChatRooms = clusterAnnotation.memberAnnotations.count
            
            if totalChatRooms >= 1 {
                self.image = drawClusterAnnotationImage(count: totalChatRooms)
                self.displayPriority = .defaultLow
            }
        }
    }
    
    private func drawClusterAnnotationImage(count: Int) -> UIImage {
        let width: CGFloat = .init(30 + count * 2)
        let height: CGFloat = .init(30 + count * 2)
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        return renderer.image { _ in
            UIColor.primaryColor?.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: width, height: height)).fill()
            
            let text = "\(count)"
            let textAttibutes = [
                NSAttributedString.Key.foregroundColor: UIColor.secondaryBackground,
                NSAttributedString.Key.font: UIFont.ntTextLargeRegular
            ]
            let size = text.size(withAttributes: textAttibutes as [NSAttributedString.Key: Any])
            let rect = CGRect(
                x: (width - size.width) / 2,
                y: (height - size.height) / 2,
                width: size.width,
                height: size.height
            )
            text.draw(in: rect, withAttributes: textAttibutes as [NSAttributedString.Key: Any])
        }
    }
}
