//
//  XKMessageView.m
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XKMessageView.h"

#import <WebKit/WebKit.h>

#import "XKAppDelegate.h"

@interface XKMessageView ()
@end


@implementation XKMessageView

@synthesize controlView = _controlView;
@synthesize webView = _webView;
@synthesize desiredHeight = _desiredHeight;
@synthesize delegate = _delegate;


- (void)awakeFromNib {
  [[self webView] setFrameLoadDelegate:self];
  [[[[self webView] mainFrame] frameView] setAllowsScrolling:NO];
}


- (NSString *)lookupKey {
  return [NSString stringWithFormat:@"%p",self];
}


- (void)webView:(WebView *)webView didFinishLoadForFrame:(WebFrame *)webFrame {
  if( webFrame == [[self webView] mainFrame] ) {
    [self updateDesiredHeightOfWebViewNotifyingTable];
  }
}


- (void)updateDesiredHeightOfWebViewNotifyingTable {
  [self updateDesiredHeightOfWebView];
  [[self delegate] tableRowView:self hasDesiredHeight:[self desiredHeight]];
}


- (void)updateDesiredHeightOfWebView {
  WebFrame *mainFrame = [[self webView] mainFrame];
  DOMDocument *document = [mainFrame DOMDocument];
  
  DOMElement *container = [document getElementById:@"container"];
  if( container ) {
    CGFloat contentHeight = [container offsetHeight] + 32;
//    NSLog( @"contentHeight = %g", contentHeight );
    
    [self setDesiredHeight:contentHeight+NSHeight( [[self controlView] frame] )];
  }
}


@end
