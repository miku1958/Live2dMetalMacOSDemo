
/**
 * Copyright(c) Live2D Inc. All rights reserved.
 *
 * Use of this source code is governed by the Live2D Open Software license
 * that can be found at https://www.live2d.com/eula/live2d-open-software-license-agreement_en.html.
 */

#import "AppDelegate.h"
#import <iostream>
#import "ViewController.h"
#import "LAppAllocator.h"
#import "LAppPal.h"
#import "LAppDefine.h"
#import "LAppLive2DManager.h"
#import "LAppTextureManager.h"

@interface AppDelegate ()

@property (nonatomic) LAppAllocator cubismAllocator; // Cubism SDK Allocator
@property (nonatomic) Csm::CubismFramework::Option cubismOption; // Cubism SDK Option
@property (nonatomic) bool captured; // クリックしているか
@property (nonatomic) float mouseX; // マウスX座標
@property (nonatomic) float mouseY; // マウスY座標
@property (nonatomic) bool isEnd; // APPを終了しているか
@property (nonatomic, readwrite) LAppTextureManager *textureManager; // テクスチャマネージャー
@property (nonatomic) Csm::csmInt32 sceneIndex;  //アプリケーションをバッググラウンド実行するときに一時的にシーンインデックス値を保存する

@end

@implementation AppDelegate

+ (AppDelegate *)shared {
    return [[self alloc] init];
}

+ (AppDelegate *)allocWithZone:(struct _NSZone *)zone{
    static AppDelegate *instance;

    static dispatch_once_t onceToken;
    // onceToken默认为0

    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        // dispatch_once宏可以保证在多线程环境下，块代码中的指令只被执行一次
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textureManager = [[LAppTextureManager alloc]init];
        _windowController = [[NSWindowController alloc] initWithWindow:[[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 1000, 1000) styleMask:NSWindowStyleMaskBorderless | NSWindowStyleMaskFullScreen | NSWindowStyleMaskFullSizeContentView backing:NSBackingStoreBuffered defer:NO]];

        _viewController = [[ViewController alloc] init];

    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _windowController.window.contentViewController = _viewController;
    _windowController.window.contentView = _viewController.view;
    
    [self initializeCubism];


    [_windowController.window makeKeyAndOrderFront:nil];

    [NSApp activate];

    [self.viewController initializeSprite];
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
  return YES;
}

- (void)initializeCubism
{
    _cubismOption.LogFunction = LAppPal::PrintMessage;
    _cubismOption.LoggingLevel = LAppDefine::CubismLoggingLevel;

    Csm::CubismFramework::StartUp(&_cubismAllocator,&_cubismOption);

    Csm::CubismFramework::Initialize();

    [LAppLive2DManager getInstance];

    Csm::CubismMatrix44 projection;

    LAppPal::UpdateTime();

}

- (bool)getIsEnd
{
    return _isEnd;
}

- (void)finishApplication
{
    [self.viewController releaseView];

    _textureManager = nil;

    Csm::CubismFramework::Dispose();

    _isEnd = true;

    exit(0);
}

@end
