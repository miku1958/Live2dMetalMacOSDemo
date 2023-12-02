//
//  main.m
//  DemoMac
//
//  Created by mi on 2023/12/2.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    NSApplication.sharedApplication.delegate = [AppDelegate shared];
    return NSApplicationMain(argc, argv);
}
