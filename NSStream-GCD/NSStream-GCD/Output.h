//
//  Output.h
//  NSStream-GCD
//
//  Created by David Hoerl on 8/13/19.
//  Copyright © 2019 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyOutputStream;

NS_ASSUME_NONNULL_BEGIN

@interface Output : NSObject

@property (nonatomic, strong, readonly) NSOutputStream *output;

- (instancetype)initWithQueue:(dispatch_queue_t) queue;
- (void)run;

@end

NS_ASSUME_NONNULL_END
