//
//  ViewController.swift
//  NSStream-GCD
//
//  Created by David Hoerl on 8/13/19.
//  Copyright © 2019 Self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	let queue = DispatchQueue(label: "Tester", qos: .background, attributes: [], target: DispatchQueue.global(qos: .background))
	lazy var output: Output = Output(queue: self.queue)
	lazy var input: Input = Input(queue: self.queue, output: output.output)

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		output.run()
		input.run()
	}

}

