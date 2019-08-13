//
//  Output.m
//  NSStream-GCD
//
//  Created by David Hoerl on 8/13/19.
//  Copyright © 2019 Self. All rights reserved.
//

@import Foundation;

#import "Output.h"

@interface Output()  <NSStreamDelegate>
@end


@implementation Output{
	NSOutputStream *output;
	dispatch_queue_t queue;
}

- (instancetype)initWithQueue:(dispatch_queue_t) q {
	self = [super init];

	queue = q;
	output = [NSOutputStream init];
	CFWriteStreamSetDispatchQueue((__bridge CFWriteStreamRef)output, queue);
	return self;
}

@end

@implementation Output(NSStreamDelegate)

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
	switch(eventCode) {
	case NSStreamEventHasBytesAvailable:
//		size_t len = [aStream xxx];
//		NSLog(@"GOT %d bytes!", len);
		break;
	case NSStreamEventErrorOccurred:

	default:
		NSLog(@"EVENT CODE %d", (int)eventCode);
		abort();
	}

}

@end
