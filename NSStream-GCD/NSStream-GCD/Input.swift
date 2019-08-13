//
//  Output.swift
//  NSStream-GCD
//
//  Created by David Hoerl on 8/13/19.
//  Copyright © 2019 Self. All rights reserved.
//

import UIKit


final class Input: NSObject {

	var data = Data()
	let stream: InputStream
	let queue: DispatchQueue

	init(queue q: DispatchQueue) {
	
		guard let path = Bundle.main.path(forResource: "Space6", ofType: "jpg") else { fatalError() }
		//let url = URL(fileURLWithPath: path)
		guard let inputStream = InputStream(fileAtPath: path) else { fatalError() }
		stream = inputStream
		queue = q
		CFReadStreamSetDispatchQueue(stream, queue)
		super.init()

		stream.delegate = self
	}

	func run() {
		stream.open()
	}

}
extension Input: StreamDelegate {

	func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
		dispatchPrecondition(condition: .onQueue(self.queue))
		
		switch eventCode {
		case .openCompleted:
			print("OPEN COMPLETED")
		case .endEncountered:
			print("AT END :-)")
			self.stream.close()
		case .hasBytesAvailable:
			let bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: 100_000)
//			self.data.append(bytes, count: size)
			let read = self.stream.read(bytes, maxLength: 100_000)
			print("READ \(read) bytes!")
		case .errorOccurred:
			print("WTF!!! Error")
			break;
		default:
			print("UNEXPECTED \(eventCode)", String(describing: eventCode))
		}
	}


}
