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

- (void)awakeFromNib {
  NSMutableArray *list = [NSMutableArray array];
  for( int i = 0; i < 100; i++ ) {
    NSInteger paras = 1 + random() % 32;
    NSMutableString *markup = [NSMutableString stringWithFormat:@"<html>\n<body><div id='container'>\n<h1>Row %d, Paras = %ld</h1>\n",i,paras];
    while( paras-- > 0 ) {
      [markup appendFormat:@"<p>Hello from para %ld</p>\n",paras];
    }
    [markup appendFormat:@"</div></body>\n</html>\n"];
    [list addObject:markup];
  }
  _data = list;
  
  NSNumber *defaultRowHeightValue = [NSNumber numberWithInteger:128];
  _rowHeightCache = [NSMutableDictionary dictionaryWithCapacity:[_data count]];
  for( NSInteger row = 0; row <= [_data count]; row += 1 ) {
    [_rowHeightCache setObject:defaultRowHeightValue forKey:[NSNumber numberWithInteger:row]];
  }
}


- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return [_data count];
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  XKMessageView *view = [tableView makeViewWithIdentifier:@"MessageCell" owner:self];
  [view setDelegate:self];
  [[[view webView] mainFrame] loadHTMLString:[_data objectAtIndex:row] baseURL:[NSURL URLWithString:@"http://127.0.0.1/"]];
  return view;
}


- (void)tableRowView:(XKMessageView *)view hasDesiredHeight:(CGFloat)height {
  NSInteger row = [[self tableView] rowForView:view];
  [_rowHeightCache setObject:[NSNumber numberWithDouble:height] forKey:[NSNumber numberWithInteger:row]];
  [[self tableView] noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndex:row]];
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
  
  NSNumber *rowHeightValue = [_rowHeightCache objectForKey:[NSNumber numberWithInteger:row]];
  if( rowHeightValue ) {
    height = [rowHeightValue doubleValue];
  } else {
    NSLog( @"No cached row height for row: %ld", row );
  }
  
  
//  if( row == [tableView selectedRow] ) {
//    XKMessageView *messageView = [tableView viewAtColumn:0 row:row makeIfNecessary:NO];
//    if( messageView ) {
//      height = MAX( height, [messageView desiredHeight] );
//    } else {
//      
//      NSLog( @"no message view for row %ld", row );
//    }
//  }
  
//  NSLog( @"Height of row %ld = %g", row, height );
  
  return height;
}


- (void)windowResized:(NSNotification *)notification {
  [self resampleVisibleTableRowHeights];
//  if( [[self tableView] selectedRow] >= 0 ) {
//    if( [notification object] == [self window] ) {
//      XKMessageView *messageView = [[self tableView] viewAtColumn:0 row:[[self tableView] selectedRow] makeIfNecessary:NO];
//      [messageView updateDesiredHeightOfWebView];
//    }
//  }
}


- (void)resampleVisibleTableRowHeights {
  NSMutableIndexSet *updatedIndices = [NSMutableIndexSet indexSet];
  [[self tableView] enumerateAvailableRowViewsUsingBlock:^(NSTableRowView *rowView, NSInteger row) {
    XKMessageView *messageView = [[self tableView] viewAtColumn:0 row:row makeIfNecessary:NO];
    [messageView updateDesiredHeightOfWebViewNotifyingTable];
    [updatedIndices addIndex:row];
  }];
  NSLog( @"Updating indexes = %@", updatedIndices );
  [[self tableView] noteHeightOfRowsWithIndexesChanged:updatedIndices];
}



@end
