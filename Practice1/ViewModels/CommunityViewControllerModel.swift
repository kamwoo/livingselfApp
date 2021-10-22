//
//  CommunityViewControllerModel.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/20.
//

import Foundation
import UIKit
import RxSwift

class CommunityViewControllerModel: NSObject{
    
    var images = [UIImage]()

    var urls : [String] = [
       "https://i.pinimg.com/236x/3f/2d/6a/3f2d6a16d6b05b0d42e4a34a3aa831fa.jpg",
        "https://mblogthumb-phinf.pstatic.net/MjAxOTA5MDVfNTAg/MDAxNTY3NjQ5OTMzODY4.fNMk2Lo4TmO5s1ojkavaHDRX1nlCKwVErKyjfWQYnOEg.Qr3WcCMA30yxv31pkC69CBwzlwX2z374WgXG-VBSlPAg.JPEG.neozion7/58003931_2387399978206401_1408838909055467520_n.jpg?type=w800",
        "https://mblogthumb-phinf.pstatic.net/MjAyMDAyMTNfMTc1/MDAxNTgxNTYxNTcyMTA0.0ZI3U3gDPpeIZwrLk_hBKaj4AX2toVC7qWttISky_I4g.S3dtcNwSLhN2iakYm3hhfubQTRhD4NRiVOREpSi41MQg.PNG.lccthebox4/image.png?type=w800",
        "https://i.pinimg.com/474x/dd/e6/5e/dde65e628d5af368bd80ec2699223b53.jpg",
        "https://file3.instiz.net/data/cached_img/upload/2020/06/03/17/1e383a9f4c3b2f06ae72fbb86e6445eb.jpg",
        "https://i.pinimg.com/236x/3f/2d/6a/3f2d6a16d6b05b0d42e4a34a3aa831fa.jpg",
         "https://mblogthumb-phinf.pstatic.net/MjAxOTA5MDVfNTAg/MDAxNTY3NjQ5OTMzODY4.fNMk2Lo4TmO5s1ojkavaHDRX1nlCKwVErKyjfWQYnOEg.Qr3WcCMA30yxv31pkC69CBwzlwX2z374WgXG-VBSlPAg.JPEG.neozion7/58003931_2387399978206401_1408838909055467520_n.jpg?type=w800",
         "https://mblogthumb-phinf.pstatic.net/MjAyMDAyMTNfMTc1/MDAxNTgxNTYxNTcyMTA0.0ZI3U3gDPpeIZwrLk_hBKaj4AX2toVC7qWttISky_I4g.S3dtcNwSLhN2iakYm3hhfubQTRhD4NRiVOREpSi41MQg.PNG.lccthebox4/image.png?type=w800",
         "https://i.pinimg.com/474x/dd/e6/5e/dde65e628d5af368bd80ec2699223b53.jpg",
         "https://file3.instiz.net/data/cached_img/upload/2020/06/03/17/1e383a9f4c3b2f06ae72fbb86e6445eb.jpg",
        "https://i.pinimg.com/236x/3f/2d/6a/3f2d6a16d6b05b0d42e4a34a3aa831fa.jpg",
         "https://mblogthumb-phinf.pstatic.net/MjAxOTA5MDVfNTAg/MDAxNTY3NjQ5OTMzODY4.fNMk2Lo4TmO5s1ojkavaHDRX1nlCKwVErKyjfWQYnOEg.Qr3WcCMA30yxv31pkC69CBwzlwX2z374WgXG-VBSlPAg.JPEG.neozion7/58003931_2387399978206401_1408838909055467520_n.jpg?type=w800",
         "https://mblogthumb-phinf.pstatic.net/MjAyMDAyMTNfMTc1/MDAxNTgxNTYxNTcyMTA0.0ZI3U3gDPpeIZwrLk_hBKaj4AX2toVC7qWttISky_I4g.S3dtcNwSLhN2iakYm3hhfubQTRhD4NRiVOREpSi41MQg.PNG.lccthebox4/image.png?type=w800",
         "https://i.pinimg.com/474x/dd/e6/5e/dde65e628d5af368bd80ec2699223b53.jpg",
         "https://file3.instiz.net/data/cached_img/upload/2020/06/03/17/1e383a9f4c3b2f06ae72fbb86e6445eb.jpg",
        "https://i.pinimg.com/236x/3f/2d/6a/3f2d6a16d6b05b0d42e4a34a3aa831fa.jpg",
         "https://mblogthumb-phinf.pstatic.net/MjAxOTA5MDVfNTAg/MDAxNTY3NjQ5OTMzODY4.fNMk2Lo4TmO5s1ojkavaHDRX1nlCKwVErKyjfWQYnOEg.Qr3WcCMA30yxv31pkC69CBwzlwX2z374WgXG-VBSlPAg.JPEG.neozion7/58003931_2387399978206401_1408838909055467520_n.jpg?type=w800",
         "https://mblogthumb-phinf.pstatic.net/MjAyMDAyMTNfMTc1/MDAxNTgxNTYxNTcyMTA0.0ZI3U3gDPpeIZwrLk_hBKaj4AX2toVC7qWttISky_I4g.S3dtcNwSLhN2iakYm3hhfubQTRhD4NRiVOREpSi41MQg.PNG.lccthebox4/image.png?type=w800",
         "https://i.pinimg.com/474x/dd/e6/5e/dde65e628d5af368bd80ec2699223b53.jpg",
         "https://file3.instiz.net/data/cached_img/upload/2020/06/03/17/1e383a9f4c3b2f06ae72fbb86e6445eb.jpg",
        "https://i.pinimg.com/236x/3f/2d/6a/3f2d6a16d6b05b0d42e4a34a3aa831fa.jpg",
         "https://mblogthumb-phinf.pstatic.net/MjAxOTA5MDVfNTAg/MDAxNTY3NjQ5OTMzODY4.fNMk2Lo4TmO5s1ojkavaHDRX1nlCKwVErKyjfWQYnOEg.Qr3WcCMA30yxv31pkC69CBwzlwX2z374WgXG-VBSlPAg.JPEG.neozion7/58003931_2387399978206401_1408838909055467520_n.jpg?type=w800",
         "https://mblogthumb-phinf.pstatic.net/MjAyMDAyMTNfMTc1/MDAxNTgxNTYxNTcyMTA0.0ZI3U3gDPpeIZwrLk_hBKaj4AX2toVC7qWttISky_I4g.S3dtcNwSLhN2iakYm3hhfubQTRhD4NRiVOREpSi41MQg.PNG.lccthebox4/image.png?type=w800",
         "https://i.pinimg.com/474x/dd/e6/5e/dde65e628d5af368bd80ec2699223b53.jpg",
         "https://file3.instiz.net/data/cached_img/upload/2020/06/03/17/1e383a9f4c3b2f06ae72fbb86e6445eb.jpg",
    ]

    private func converImage(url: String){
        let url = URL(string: url)
        var image : UIImage?
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { [weak self] in
                image = UIImage(data: data!)
                self?.images.append(image!)
            }
        }
    }

    override init(){
        super.init()
        urls.map{self.converImage(url: $0)}
    }
    
}
