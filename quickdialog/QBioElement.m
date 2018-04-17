//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "QBioElement.h"
#import "QuickDialog.h"
@implementation QBioElement

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    QEntryTableViewCell *cell = (QEntryTableViewCell *) [super getCellForTableView:tableView controller:controller];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = self.enabled ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
    cell.textField.enabled = NO;
    cell.textField.textAlignment = NSTextAlignmentCenter;
    cell.textField.textColor = [UIColor colorWithRed:0 green:48/255 blue:72/255 alpha:1];
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:13];
    if (!font) {
        font = [UIFont systemFontOfSize: 13];
    }
    cell.textField.font = font;

    return cell;
}

- (void)selected:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller indexPath:(NSIndexPath *)indexPath
{
    QMultilineTextViewController *textController = [[QMultilineTextViewController alloc] initWithTitle:self.title];
    textController.entryElement = self;
    textController.entryCell = (QEntryTableViewCell *) [tableView cellForElement:self];
    textController.resizeWhenKeyboardPresented = YES;
    textController.textView.text = self.textValue;
    textController.textView.autocapitalizationType = self.autocapitalizationType;
    textController.textView.autocorrectionType = self.autocorrectionType;
    textController.textView.keyboardAppearance = self.keyboardAppearance;
    textController.textView.keyboardType = self.keyboardType;
    textController.textView.secureTextEntry = self.secureTextEntry;
    textController.textView.autocapitalizationType = self.autocapitalizationType;
    textController.textView.returnKeyType = self.returnKeyType;
    textController.textView.editable = self.enabled;
    textController.textView.textColor = [UIColor colorWithRed:0 green:48/255 blue:72/255 alpha:1];
    textController.textView.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:13];
    if (!font) {
        font = [UIFont systemFontOfSize: 13];
    }
    textController.textView.font = font;
    
    __weak QMultilineElement *weakSelf = self;
    __weak QMultilineTextViewController *weakTextController = textController;
    textController.willDisappearCallback = ^ {
        weakSelf.textValue = weakTextController.textView.text;
        [[tableView cellForElement:weakSelf] setNeedsDisplay];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    };
    [controller displayViewController:textController withPresentationMode:self.presentationMode];
}

@end

