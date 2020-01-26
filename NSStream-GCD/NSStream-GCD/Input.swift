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
	let inputStream: InputStream
	let outputStream: OutputStream
	let queue: DispatchQueue

	init(queue q: DispatchQueue, output: OutputStream) {
		guard let path = Bundle.main.path(forResource: "Space6", ofType: "jpg") else { fatalError() }
		guard let input = InputStream(fileAtPath: path) else { fatalError() }
		inputStream = input
		outputStream = output
		queue = q
		CFReadStreamSetDispatchQueue(inputStream, queue)

		super.init()

		inputStream.delegate = self
	}

	func run() {
		inputStream.open()
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
			self.inputStream.close()
		case .hasBytesAvailable:
			let bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: 100_000)
			let readLen = self.inputStream.read(bytes, maxLength: 100_000)
			if self.outputStream.hasSpaceAvailable {
				let writeLen = self.outputStream.write(bytes, maxLength: readLen)
				print("READ: writeLen=\(writeLen)")
			} else {
				print("READ: no space!!!")
			}
			print("READ \(readLen) bytes!")
		case .errorOccurred:
			print("WTF!!! Error")
			break;
		default:
			print("UNEXPECTED \(eventCode)", String(describing: eventCode))
		}
	}


}
