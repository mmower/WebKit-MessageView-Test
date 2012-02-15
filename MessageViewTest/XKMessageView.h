//
//  XKMessageView.h
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <WebKit/WebKit.h>

@interface XKMessageView : NSView

@property (assign) IBOutlet NSView *controlView;
@property (assign) IBOutlet WebView *webView;
@property (assign) CGFloat desiredHeight;

- (void)updateDesiredHeightOfWebView;

@end
