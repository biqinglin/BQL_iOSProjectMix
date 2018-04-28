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


### 此外，还提供类名、方法名混淆，提供两个文件：func.list、confuse.sh
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

