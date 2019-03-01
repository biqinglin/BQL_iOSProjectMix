## 混淆方案组合一 混淆调用树
> 本项目源码地址 : `https://github.com/HikariObfuscator/Hikari`
>
> 其实他是基于 [obfuscator](https://github.com/obfuscator-llvm/obfuscator) 进行了Xcode9的适配

### 开始

#### install

> 下载 [Hikari](http://7xunik.com1.z0.glb.clouddn.com/Hikari.zip)
>
> mkdir build
>
> cd build
>
> cmake -DCMAKE_BUILD_TYPE=Release ../Hikari/
>
> make -j7

#### setup

```
$ cd /Applications/Xcode.app/Contents/PlugIns/Xcode3Core.ideplugin/Contents/SharedSupport/Developer/Library/Xcode/Plug-ins/
$ sudo cp -r Clang\ LLVM\ 1.0.xcplugin/ Obfuscator.xcplugin
$ cd Obfuscator.xcplugin/Contents/
$ sudo plutil -convert xml1 Info.plist
$ sudo vim Info.plist

```
#### change:

```
<string>com.apple.compilers.clang</string> -> <string>com.apple.compilers.obfuscator</string>
<string>Clang LLVM 1.0 Compiler Xcode Plug-in</string> -> <string>Obfuscator Xcode Plug-in</string>
```

#### Then:

```
$ sudo plutil -convert binary1 Info.plist
$ cd Resources/
$ sudo mv Clang\ LLVM\ 1.0.xcspec Obfuscator.xcspec
$ sudo vim Obfuscator.xcspec
```

#### Change:

```
<key>Description</key>
<string>Apple LLVM 9.0 compiler</string> -> <string>Obfuscator 4.0 compiler</string>
<key>ExecPath</key>
<string>clang</string> -> <string>/$(install步骤里面的build文件路径)/bin/clang</string>
<key>Identifier</key>
<string>com.apple.compilers.llvm.clang.1_0</string> -> <string>com.apple.compilers.llvm.obfuscator.4_0</string>
<key>Name</key>
<string>Apple LLVM 9.0</string> -> <string>Obfuscator 4.0</string>
<key>Vendor</key>
<string>Apple</string> -> <string>HEIG-VD</string>
<key>Version</key>
<string>9.0</string> -> <string>4.0</string>
```

#### Then:

```
$ cd English.lproj/
$ sudo mv Apple\ LLVM\ 9.0.strings "Obfuscator 3.4.strings"
$ sudo plutil -convert xml1 Obfuscator\ 3.4.strings
$ sudo vim Obfuscator\ 3.4.strings
```

#### Change:

```
<key>Description</key>
<string>Apple LLVM 9.0 compiler</string> -> <string>Obfuscator 4.0 compiler</string>
<key>Name</key>
<string>Apple LLVM 9.0</string> -> <string>Obfuscator 4.0</string>
<key>Vendor</key>
<string>Apple</string> -> <string>HEIG-VD</string>
<key>Version</key>
<string>7.0</string> -> <string>4.0</string>
```

#### Then:

```
$ sudo plutil -convert binary1 Obfuscator\ 3.4.strings
```

### 使用
> Build Settings -> Compiler for C/C++/Objective-C -> Obfuscator 4.0
>
> Build Setting -> Enable Index-While-Building Functionality ->  'default' change to 'No'
>
> 关闭 bitcode
>
> 关闭编译优化 Build Settings -> OPTIMIZATION_LEVEL -> 0
>
> 开启混淆, Build Settings -> OTHER_CFLAGS -> `-mllvm -enable-cffobf` `-mllvm -enable-bcfobf`


### 此方式修改了你的编译器，使得在编译时在代码中添加混淆代码（在不影响应用本身逻辑的前提下），上面的步骤只需要一次就行，如果更新了系统有可能导致失效，只需要从setup再来一遍即可，下面做了一个测试，反编译一个使用了混淆与不使用混淆的ipa包，查看调用树形图可以看到对比:
![未使用混淆](http://occmuwiio.bkt.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-04-04%20%E4%B8%8B%E5%8D%883.42.30.png)
![使用混淆](http://occmuwiio.bkt.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202018-04-04%20%E4%B8%8B%E5%8D%883.44.55.png)


## 混淆方案组合二 混淆方法名，类名
### 提供两个文件：func.list、confuse.sh
##### func.list 
> 罗列出需要混淆的类名、方法名
##### confuse.sh
> 脚本文件

#### 使用：
> 将要混淆的方法名、类名 填入func.list 文件里面。项目里不要引入func.list文件
>
> Build Phases 点击'+',new run script , Run Script -> add $PROJECT_DIR/confuse.sh
>
> command + B 将生成的 codeObfuscation.h加入项目

### PS：我们使用这套方案，（2种）目的是为了混淆我们的SDK（当然了，这个SDK对苹果爸爸来说是不合规的）,目前暂未出现因为机审不过的情况，通常是因为马甲本身的功能不够丰富。另外方案一有可能导致当前项目无法使用xib以及无法继承自定义类的情况，暂时无法解决，发生几率不高，但是还是建议在工程做完之后再修改编译方式。

我们现在有更骚的操作，过包率维持在90%，而且稳定的一匹。。。之前的混淆可能导致一锅端，目前暂未发现这种情况
