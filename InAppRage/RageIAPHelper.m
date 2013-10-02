//
//  RageIAPHelper.m
//  InAppRage
//
//  Created by Brian McCaul on 10/2/13.
//  Copyright (c) 2013 Brian McCaul. All rights reserved.
//

#import "RageIAPHelper.h"

@implementation RageIAPHelper

+ (RageIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static RageIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.brianmccaul.inapprage.drummerrage",
                                      @"com.brianmccaul.inapprage.itunesconnectrage",
                                      @"com.brianmccaul.inapprage.nightlyrage",
                                      @"com.brianmccaul.inapprage.studylikeaboss",
                                      @"com.brianmccaul.inapprage.updogsadness",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end