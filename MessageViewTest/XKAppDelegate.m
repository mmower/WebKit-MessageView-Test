//
//  XKAppDelegate.m
//  MessageViewTest
//
//  Created by Matt Mower on 13/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XKAppDelegate.h"

#import "XKMessageView.h"
#import "XKInfoPopoverViewController.h"

#import <WebKit/WebKit.h>

@implementation XKAppDelegate

@synthesize window = _window;
@synthesize tableView = _tableView;
@synthesize infoPopover = _infoPopover;
@synthesize infoPopoverViewController = _infoPopoverViewController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowResized:) name:NSWindowDidResizeNotification object:[self window]];
  
}

- (void)awakeFromNib {
  _tableLock = NO;
  
  NSMutableArray *list = [NSMutableArray array];
  for( int i = 0; i < 100; i++ ) {
    NSInteger paras = 1 + random() % 32;
    NSMutableString *markup = [NSMutableString stringWithFormat:@"<html>\n<head>\n<style>\nbody { background: blue; };\n#container { background: red; };\n</style>\n</head>\n<body><div id='container'>\n<h1>Row %d, Paras = %ld</h1>\n",i,paras];
    while( paras-- > 0 ) {
      [markup appendFormat:@"<p>Hello from para %ld</p>\n",paras];
    }
    [markup appendFormat:@"</div></body>\n</html>\n"];
    [list addObject:markup];
  }
  _data = list;
  
  [[self tableView] setGridStyleMask:NSTableViewSolidHorizontalGridLineMask];
  [[self tableView] setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
  
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
  NSLog( @"View for row %3ld has desired height = %g", row, height );
  [_rowHeightCache setObject:[NSNumber numberWithDouble:height] forKey:[NSNumber numberWithInteger:row]];
  if( !_tableLock ) {
    [[self tableView] noteHeightOfRowsWithIndexesChanged:[NSIndexSet indexSetWithIndex:row]];
  } else {
    NSLog( @"TABLE LOCKED" );
  }
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
  }
  NSLog( @"Returning row height %g for row %3ld", height, row );
  return height;
}


- (void)windowResized:(NSNotification *)notification {
  [self resampleVisibleTableRowHeights];
}


- (void)resampleVisibleTableRowHeights {
  NSMutableIndexSet *updatedIndices = [NSMutableIndexSet indexSet];
  _tableLock = YES;
  [[self tableView] enumerateAvailableRowViewsUsingBlock:^(NSTableRowView *rowView, NSInteger row) {
    XKMessageView *messageView = [rowView viewAtColumn:0];
    [messageView updateDesiredHeightOfWebViewNotifyingTable];
    [updatedIndices addIndex:row];
  }];
  _tableLock = NO;
  [[self tableView] noteHeightOfRowsWithIndexesChanged:updatedIndices];
}


- (IBAction)clicked:(id)sender {
  XKMessageView *view = (XKMessageView *)[[sender superview] superview];
  [[[self infoPopoverViewController] heightField] setStringValue:[NSString stringWithFormat:@"%g", [view desiredHeight]]];
  [[self infoPopover] showRelativeToRect:[view bounds] ofView:view preferredEdge:NSMaxXEdge];
}


@end
