//
//  IAPHelper.h
//  InAppRage
//
//  Created by Brian McCaul on 10/1/13.
//  Copyright (c) 2013 Brian McCaul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

// an initializer that takes a list of product identifiers (such as com.razeware.inapprage.nightlyrage)
- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;

// asynchronous method to retrieve info about the products from iTunes Connect.
// Takes a block as a parameter so it can notify the caller when it is complete.
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end