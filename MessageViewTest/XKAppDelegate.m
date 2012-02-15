//
//  XKAppDelegate.m
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XKAppDelegate.h"

#import "XKMessageView.h"

#import <WebKit/WebKit.h>

@implementation XKAppDelegate

@synthesize window = _window;
@synthesize tableView = _tableView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowResized:) name:NSWindowDidResizeNotification object:[self window]];
  
}


- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return 100;
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  XKMessageView *view = [tableView makeViewWithIdentifier:@"MessageCell" owner:self];
  
  NSInteger paras = 1 + random() % 32;
  NSMutableString *markup = [NSMutableString stringWithFormat:@"<html>\n<body>\n<h1>Paras = %ld</h1>\n",paras];
  while( paras-- > 0 ) {
    [markup appendFormat:@"<p>Hello from para %ld</p>\n",paras];
  }
  [markup appendFormat:@"</body>\n</html>\n"];
  
  [[[view webView] mainFrame] loadHTMLString:markup baseURL:[NSURL URLWithString:@"http://127.0.0.1/"]];
  
  return view;
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification {
  NSTableView *tableView = [notification object];
  NSInteger selectedRow = [tableView selectedRow];
  
  NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
  [indexes addIndex:_previousSelectedRow];
  [indexes addIndex:selectedRow];
  [tableView noteHeightOfRowsWithIndexesChanged:indexes];
  _previousSelectedRow = selectedRow;
}


- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
  CGFloat height = 128.0;
  
  if( row == [tableView selectedRow] ) {
    XKMessageView *messageView = [tableView viewAtColumn:0 row:row makeIfNecessary:NO];
    if( messageView ) {
      height = MAX( height, [messageView desiredHeight] );
    } else {
      NSLog( @"Cannot obtain webframe to calculate document height" );
    }
  }
  
//  NSLog( @"Height = %g", height );
  
  return height;
}


- (void)windowResized:(NSNotification *)notification {
  if( [[self tableView] selectedRow] >= 0 ) {
    if( [notification object] == [self window] ) {
      XKMessageView *messageView = [[self tableView] viewAtColumn:0 row:[[self tableView] selectedRow] makeIfNecessary:NO];
      [messageView updateDesiredHeightOfWebView];
      [[self tableView] noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndex:[[self tableView] selectedRow]]];
    }
  }
}



@end
