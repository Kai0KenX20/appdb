//
//  Banner.swift
//  appdb
//
//  Created by ned on 11/10/2016.
//  Copyright © 2016 ned. All rights reserved.
//

import UIKit
import Cartography

class Banner: UITableViewCell {

    //var slideshow: ImageSlideshow!
    
    let height: CGFloat = {
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)
        
        switch screenHeight { /* Are these numbers out of my ass? Probably. There should be a better way. */
            case 480,568: return 128
            case 667: return 150
            case 736: return 165
            case 1024: return 220
            case 1366: return 250
            default: return 0
        }
        
    }()
    
    convenience init() {
        self.init(style: .default, reuseIdentifier: Featured.CellType.banner.rawValue)
        
        theme_backgroundColor = Color.tableViewBackgroundColor
        contentView.theme_backgroundColor = Color.tableViewBackgroundColor
        
        //
        // Get Promotions
        // TODO: ask fred to add banner image to API
        //
        
        /*API.getPromotions( success: { items in
            
            if items.isEmpty {
                print("no promotions to show")
            } else {
                print("found \(items.count) promotions.")
            }
            
        }, fail: { error in
                print(error.localizedDescription)
        })*/
        
        
        /*
        // Initialize Slideshow
        slideshow = ImageSlideshow()
        setImageInputs()

        // Set Up Slideshow
        slideshow.circular = true
        slideshow.zoomEnabled = false
        slideshow.pageControlPosition = .hidden
        slideshow.contentScaleMode = .scaleAspectFit
        slideshow.draggingEnabled = true
        slideshow.preload = .all
        
        // Add tap recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        slideshow.addGestureRecognizer(tapRecognizer)
        
        contentView.addSubview(slideshow)
        
        // Add constraints
        constrain(slideshow) { slideshow in
            slideshow.edges == slideshow.superview!.edges
        }
 
        */
        
    }
    
    /*
    
    /* Should be called only when view is loaded */
    func startTimer() {
        slideshow.slideshowInterval = 5.0
    }
    
    /* This is also a retry function, in case sources should be reloaded */
    func setImageInputs() {
        if let slideshow = self.slideshow {
            slideshow.setImageInputs([
                AlamofireSource(urlString: "http://appd.be/n3d/delta/k.png")!,
                AlamofireSource(urlString: "http://appd.be/n3d/delta/a.png")!
            ])
        }
    }
    
    func didTap() {
        print("did tap on \(slideshow.currentPage)") /* TODO: redirect to app page */
    }
    
    */

}
