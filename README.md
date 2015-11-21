
# linkProtocolKit

###jump to out of app

http://www.xxx.com/appOut


###jump view controller in native app

examples path map to view controller:

add view map key value in viewMap.plist
```
* code         CodeViewController
* xib          XibViewController
* storyboard   StoryBoardViewController
```
#####applinks example
http://www.xxx.com/code





the following two code blocks act the same in the class ViewController 

1.
```
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/code"];
```

2.
```
CodeViewController *code =  [[CodeViewController alloc] init];
code.view.backgroundColor = [UIColor lightGrayColor];
[self.navigationController pushViewController:code animated:YES];
*/
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/code"];
}
```



http://www.xxx.com/xib
#####configuration a property in view controller
* http://www.xxx.com/xib?text=你好

the following two code blocks act the same in the class ViewController 

1.
```javascript
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/xib?text=abc"];
```

2.
```javascript
XibViewController *xibViewController =  [[XibViewController alloc] initWithNibName:@"XibViewController" bundle:nil];
xibViewController.xibString = @"abc";
[self.navigationController pushViewController:xibViewController animated:YES];
```


http://www.xxx.com/storyboard

the following two code blocks act the same in the class ViewController 

1.
```javascript
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/storyboard"];
```

2.
```javascript
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
StoryBoardViewController *storyBoardVC = [storyboard instantiateViewControllerWithIdentifier:@"storyboardViewController"];
[self.navigationController pushViewController:storyBoardVC animated:YES];
```

