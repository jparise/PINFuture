//
//  PINTask2+Map.h
//  Pods
//
//  Created by Chris Danford on 12/14/16.
//  Copyright (c) 2016 Pinterest. All rights reserved.
//

#import "PINResult.h"
#import "PINTask.h"
#import "PINTask2.h"

@interface PINTask2<FromType, ToType> (Map)
+ (PINTask<ToType> *)executor:(id<PINExecutor>)executor map:(PINTask<FromType> *)sourceTask success:(PINResult<ToType> *(^)(FromType fromValue))success PIN_WARN_UNUSED_RESULT;
@end
