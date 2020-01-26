//
//  MyOutputStream.m
//  NSStream-GCD
//
//  Created by David Hoerl on 8/13/19.
//  Copyright © 2019 Self. All rights reserved.
//

#import "MyOutputStream.h"

//@interface MyOutputStream : NSOutputStream
//
////@property (nonatomic, strong, readonly) NSMutableData *data;
//
//@end

@interface MyOutputStream ()

//@property (nonatomic, strong, readwrite) NSMutableData *data;

@end

@implementation MyOutputStream

- (instancetype)initToMemory {
	self = [super initToMemory];
	//_data = [NSMutableData new];
	return self;
}

- (void)open {
	[super open];
}

- (BOOL)hasSpaceAvailable {
	return YES;
}

- (NSInteger)write:(const uint8_t *)buffer maxLength:(NSUInteger)len {
//	[self.data appendBytes:buffer length:len];
	return len;
}

@end
