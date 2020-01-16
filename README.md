[![Build Status](https://app.bitrise.io/app/fae70b8f60741639/status.svg?token=kHepFoJ1pOZ2YZOv6XIlFw)](https://app.bitrise.io/app/fae70b8f60741639)


# Integration of SalemoveSDK using Carthage

*Demoes minimal setup required to get the SalemoveSDK/GliaSDK integrated using Carthage package manager.*


### Sample was created with 
* XCode 11.2.1 (`/usr/bin/xcodebuild -version`)
* Swift 5.1.2 (`xcrun swift -version`)
* Carthage 0.33.0 (`carthage version`)

### Integration steps

#### 1) Ensure that SalemoveSDK dependency in your Cartfile specifies version tag
This way you always get the Released state of the SDK

* Example: `github "Salemove/ios-bundle" "0.18.0"`

#### 2) Get and build dependencies
Run `carthage update --platform iOS`

* if you get swift version incompatibility issue, then please add `--no-use-binaries`, it will build all dependencies locally to ensure compatibility with your environment.
* This takes some time to finish.

##### Known issue 1:

* 1) `Skipped building ios-webrtc due to the error`
* 2) `Skipped building ios-bundle due to the error`

Both errors show up because of prebuilt frameworks for *ios-webrtc* and *ios-bundle*. These frameworks already exist and do not need to be built. And as they already exist (in `Carthage/checkouts` directory) then we do not need to worry about these errors.

##### Known issue 2:

```
objc[1315]: Class RTCCVPixelBuffer is implemented in both /System/Library/PrivateFrameworks/WebCore.framework/Frameworks/libwebrtc.dylib (0x1e95f0620) and /private/var/containers/Bundle/Application/2CE8ACA6-BC52-4903-9B8F-DE2DB201570D/CarthageIntegration.app/Frameworks/WebRTC.framework/WebRTC (0x105c5d690). One of the two will be used. Which one is undefined.
```
* [https://bugs.chromium.org/p/webrtc/issues/detail?id=10560](https://bugs.chromium.org/p/webrtc/issues/detail?id=10560)

NOTE: If the command still fails due to some version mismatch or incompatibility issues, then try deleting the `Cartfile.resolved` file and `Carthage` directory and run the command again.

#### 3) Link built libraries
Carthage update command pulls and builds dependencies into *Carthage* folder.
Pulled files are placed in *Carthage/checkouts* folder and *Carthage/build* files are in *build* folder. There you find different `*.framework` files that need to be linked into your XCode project.

##### To link the files with XCode 11:
* In XCode, click your project in the *Project Navigator*. Select your *target*, choose the *General* tab at the top, and scroll down to the *Frameworks, Libraries, and Embedded Content* section at the bottom.
* Drag and drop all your `*.framework` files (except `RxTest.framework` and any other test related frameworks) from *Carthage/checkouts* and *Carthage/build* folders to that section in XCode.
* Go to *Build Settings* and type *Framework Search Paths* to find that section in settings. Doubleclick on its value and validate that these search paths are present. (If they are missing then please add.)
	* `$(inherited)`
	* `$(PROJECT_DIR)/Carthage/Build/iOS`
	* `$(PROJECT_DIR)/Carthage/Checkouts/ios-webrtc/output/bitcode`
	* `$(PROJECT_DIR)/Carthage/Checkouts/ios-bundle`

##### To link the files with older XCode:
* In XCode, click your project in the *Project Navigator*. Select your *target*, choose the *General* tab at the top, and scroll down to the *Linked Frameworks and Libraries* section at the bottom.
* Drag and drop all your `*.framework` files (except `RxTest.framework` and any other test related frameworks) from *Carthage/checkouts* and *Carthage/build* folders to that section in XCode.

##### (For XCode 10 and below) Add a Run script for Carthage:
* Go to *Build Phases* and add a new *Run Script* build phase. You can name it "Run script for Carthage".
* Add command `/usr/local/bin/carthage copy-frameworks`
* In *Input Files* section, add paths to every framework file you have just linked above.

For SalemoveSDK these need to be added to *Run Script*

* `$(SRCROOT)/Carthage/Checkouts/ios-webrtc/output/release/WebRTC.framework`
* `$(SRCROOT)/Carthage/Checkouts/ios-bundle/SalemoveSDK.framework`
* `$(SRCROOT)/Carthage/Build/iOS/Result.framework`
* `$(SRCROOT)/Carthage/Build/iOS/RxSwift.framework`
* `$(SRCROOT)/Carthage/Build/iOS/SocketIO.framework`
* `$(SRCROOT)/Carthage/Build/iOS/SwiftPhoenixClient.framework`
* `$(SRCROOT)/Carthage/Build/iOS/SwiftyBeaver.framework`
* `$(SRCROOT)/Carthage/Build/iOS/Macaw.framework`
* `$(SRCROOT)/Carthage/Build/iOS/RxMoya.framework`
* `$(SRCROOT)/Carthage/Build/iOS/Alamofire.framework`
* `$(SRCROOT)/Carthage/Build/iOS/Locksmith.framework`
* `$(SRCROOT)/Carthage/Build/iOS/SWXMLHash.framework`
* `$(SRCROOT)/Carthage/Build/iOS/RxAtomic.framework`
* `$(SRCROOT)/Carthage/Build/iOS/Starscream.framework`
* `$(SRCROOT)/Carthage/Build/iOS/ObjectMapper.framework`
* `$(SRCROOT)/Carthage/Build/iOS/RxBlocking.framework`
* `$(SRCROOT)/Carthage/Build/iOS/Moya.framework`
* `$(SRCROOT)/Carthage/Build/iOS/RxCocoa.framework`
* `$(SRCROOT)/Carthage/Build/iOS/ReactiveMoya.framework`
* `$(SRCROOT)/Carthage/Build/iOS/ReactiveSwift.framework`

### For more specific information please see latest Carthage documentation
* [https://github.com/Carthage/Carthage#adding-frameworks-to-an-application](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)


