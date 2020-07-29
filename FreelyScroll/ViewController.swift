//
//  ViewController.swift
//  FreelyScroll
//
//  Created by hicka04 on 2020/07/28.
//  Copyright © 2020 hicka04. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa

class ViewController: UIViewController {
    @IBOutlet private var scrollViews: [UIScrollView]!
    
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let offsetSubject = PassthroughSubject<CGPoint, Never>()
        scrollViews.forEach { scrollView in 
            scrollView
                .contentOffsetPublisher
                .subscribe(offsetSubject)
                .store(in: &cancellables)
            offsetSubject
                .removeDuplicates()
                .assign(to: \.contentOffset, on: scrollView)
                .store(in: &cancellables)
        }
    }
}

