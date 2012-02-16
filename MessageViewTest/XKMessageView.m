//
//  XKMessageView.m
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XKMessageView.h"

#import <WebKit/WebKit.h>

@interface XKMessageView ()
@end


@implementation XKMessageView

@synthesize controlView = _controlView;
@synthesize webView = _webView;
@synthesize desiredHeight = _desiredHeight;


- (void)awakeFromNib {
  [[self webView] setFrameLoadDelegate:self];
  [[[[self webView] mainFrame] frameView] setAllowsScrolling:NO];
}


- (void)webView:(WebView *)webView didFinishLoadForFrame:(WebFrame *)webFrame {
  if( webFrame == [[self webView] mainFrame] ) {
    [self updateDesiredHeightOfWebView];
  }
}


- (void)updateDesiredHeightOfWebView {
  WebFrame *mainFrame = [[self webView] mainFrame];
  DOMDocument *document = [mainFrame DOMDocument];
  
  DOMElement *container = [document getElementById:@"container"];
  assert( container );
  
  CGFloat contentHeight = [container offsetHeight] + 32;
  NSLog( @"contentHeight = %g", contentHeight );
  
  [self setDesiredHeight:contentHeight+NSHeight( [[self controlView] frame] )];
}


@end
