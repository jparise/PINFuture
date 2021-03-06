//
//  PINFutureTests.m
//  PINFutureTests
//
//  Created by Chris Danford on 12/02/2016.
//  Copyright (c) 2016 Pinterest. All rights reserved.
//

// https://github.com/Specta/Specta

#import "PINFuture.h"
#import "TestUtil.h"

SpecBegin(PINFutureSpecs)

describe(@"future", ^{
    it(@"create with value", ^{
        NSString *value = stringFixture();
        PINFuture<NSString *> *future = [PINFuture<NSString *> withValue:value];
        expectFutureToFulfillWith(self, future, value);
    });

    it(@"create with error", ^{
        NSError *error = errorFixture();
        PINFuture<NSString *> *future = [PINFuture<NSString *> withError:error];
        expectFutureToRejectWith(self, future, error);
    });

    it(@"resolves only once", ^{
        NSString *value = stringFixture();
        // Calls to resolve or reject after the first should be ignored.
        PINFuture<NSString *> *future = [PINFuture<NSString *> withBlock:^(void (^ _Nonnull resolve)(NSString * _Nonnull), void (^ _Nonnull reject)(NSError * _Nonnull)) {
            resolve(value);
            resolve(value);
            reject(errorFixture());
        }];
        expectFutureToFulfillWith(self, future, value);
    });

    it(@"rejects only once", ^{
        NSError *error = errorFixture();
        // Calls to resolve or reject after the first should be ignored.
        PINFuture<NSString *> *future = [PINFuture<NSString *> withBlock:^(void (^ _Nonnull resolve)(NSString * _Nonnull), void (^ _Nonnull reject)(NSError * _Nonnull)) {
            reject(error);
            reject(error);
            resolve(stringFixture());
        }];
        expectFutureToRejectWith(self, future, error);
    });

    it(@"tolerates success callback being NULL when fulfilled", ^{
        NSString *value = stringFixture();
        PINFuture<NSString *> *future = [PINFuture withValue:value];
        [future executor:[PINExecutor immediate] success:NULL failure:NULL];
        expectFutureToFulfillWith(self, future, value);
    });

    it(@"tolerates failure callback being null when rejected", ^{
        NSError *error = errorFixture();
        PINFuture<NSString *> *future = [PINFuture withError:error];
        [future executor:[PINExecutor immediate] success:NULL failure:NULL];
        expectFutureToRejectWith(self, future, error);
    });
});

SpecEnd
