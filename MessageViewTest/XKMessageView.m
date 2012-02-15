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
  
  DOMNodeList *nodes = [document getElementsByTagName:@"body"];
  DOMNode *body = [nodes item:0];
  DOMHTMLBodyElement *bodyElement = (DOMHTMLBodyElement *)body;
  
  CGFloat contentHeight = [bodyElement offsetHeight];
  contentHeight -= 1;
  NSLog( @"contentHeight = %g", contentHeight );
  
  [self setDesiredHeight:contentHeight+NSHeight( [[self controlView] frame] )];
}


//- (void)viewDidMoveToWindow {
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowResized:) name:NSWindowDidResizeNotification object:[self window]];
//}
//
//
//- (void)dealloc {
//  [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//
//- (void)windowResized:(NSNotification *)notification {
//  [self updateDesiredHeightForWebView:[self webView] webFrame:[[self webView] mainFrame]];
//}


@end
