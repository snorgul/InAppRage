//
//  IAPHelper.m
//  InAppRage
//
//  Created by Brian McCaul on 10/1/13.
//  Copyright (c) 2013 Brian McCaul. All rights reserved.
//

#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>

// mark the class as implementing SKProductsRequestDelegate protocol in the class extension
@interface IAPHelper () <SKProductsRequestDelegate>
@end

@implementation IAPHelper {
    // You create an instance variable to store the SKProductsRequest
    SKProductsRequest * _productsRequest;
    
    // keep track of the completion handler for the outstanding products request, the list of product identifiers passed in, and the list of product identifers that have been previously purchased
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        
    }
    return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    // puts a copy of the completion handler block inside the instance variable so it can notify the caller when the product request asynchronously completes
    _completionHandler = [completionHandler copy];
    
    // creates a new instance of SKProductsRequest, which is the Apple-written class that contains the code to pull the info from iTunes Connect
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }
    
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}

@end