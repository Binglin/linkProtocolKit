
# linkProtocolKit
#通过ur方式跳转web或者app native页面


###jump to out of app




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



the following two code blocks act the same
1.
```
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=code];
```

2.
```
CodeViewController *code =  [[CodeViewController alloc] init];
code.view.backgroundColor = [UIColor lightGrayColor];
[self.navigationController pushViewController:code animated:YES];

```




the following two code blocks act the same
1.
```
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=xib&text=abc"];
```
2.
```
XibViewController *xibViewController =  [[XibViewController alloc] initWithNibName:@"XibViewController" bundle:nil];
xibViewController.xibString = @"abc";
[self.navigationController pushViewController:xibViewController animated:YES];
```




/*
the following two code blocks act the same
```
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=storyboard"];

UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
StoryBoardViewController *storyBoardVC = [storyboard instantiateViewControllerWithIdentifier:@"storyboardViewController"];
[self.navigationController pushViewController:storyBoardVC animated:YES];
```
```
[[BIlinkHelper helper] openApplink:@"http://www.xxx.com/app?appinner=app&pageName=storyboard"];
```




app内部web跳转
```
http://www.xxx.com/?appinner=app&pageName=web&url=http%3A%2F%2Fwww.baidu.com 
```

