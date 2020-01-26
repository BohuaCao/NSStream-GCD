//
//  Output.m
//  NSStream-GCD
//
//  Created by David Hoerl on 8/13/19.
//  Copyright © 2019 Self. All rights reserved.
//

@import Foundation;

#import "Output.h"
#import "MyOutputStream.h"

@interface Output()  <NSStreamDelegate>

@property (nonatomic, strong, readwrite) NSOutputStream *output;

@end


@implementation Output {
	dispatch_queue_t queue;
}

- (instancetype)initWithQueue:(dispatch_queue_t) q {
	self = [super init];

	queue = q;
	_output = [[NSOutputStream alloc] initToMemory];
NSLog(@"Output Stream: %@", NSStringFromClass([_output class]));
	CFWriteStreamSetDispatchQueue((__bridge CFWriteStreamRef)_output, queue);
	return self;
}

- (void)run {

	[self.output open];
	[self probe];
}

- (void)probe {
	NSData *d = [self.output propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
NSLog(@"Output Data: %@", NSStringFromClass([d class]));



//	NSMutableData *d = self.output.myData;
//	if([d length]) {
//		NSLog(@"WRITE: problem found %td bytes", [d length]);
//		if([d length] > 1000) {
//			d.length -= 1000;
//		}
//	}
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1000 * NSEC_PER_MSEC), queue, ^{
		[self probe];
	});
}

@end

@implementation Output(NSStreamDelegate)

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
	const char *label = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
	assert(!strcmp("Tester", label));

	switch(eventCode) {
	case NSStreamEventOpenCompleted:
		NSLog(@"WRITE: open completed");
		break;
	case NSStreamEventHasBytesAvailable:
		abort();
	case NSStreamEventEndEncountered:
		NSLog(@"WRITE: end encountered");
		break;
	case NSStreamEventErrorOccurred:
		NSLog(@"WRITE: NSStreamEventErrorOccurred");
		break;
	case NSStreamEventHasSpaceAvailable:
		NSLog(@"WRITE: NSStreamEventHasSpaceAvailable");
		break;
	default:
		NSLog(@"EVENT CODE %d", (int)eventCode);
		abort();
	}

}

@end
