//
//  AppDelegate.h
//  DemoMac
//
//  Created by mi on 2023/12/2.
//

#import <Cocoa/Cocoa.h>

@class ViewController;
@class LAppView;
@class LAppTextureManager;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (class, nonatomic, readonly) AppDelegate *shared;

@property (strong, nonatomic) NSWindowController *windowController;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, readonly, getter=getTextureManager) LAppTextureManager *textureManager; // テクスチャマネージャー

/**
 * @brief   アプリケーションを終了する。
 */
- (void)finishApplication;
@end

