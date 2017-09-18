# Themify
[![Mit License][mit-badge]][mit-url][![Build Status][travis-build-url]][travis-url]

## What is Themify?

Themify is a small library that manages color themes using appearance
proxies. The ideia is to create a standardized, centralized and simple way to
create color themes that are applied to your app.

## What problem does it try to solve?

Creating color themes for an app is a boring task. You need to set color
properties over and over again, using storyboards or xib files. For large apps,
changing your color theme is hard and a no-brainer task.

If you decide to use appearance proxies, you find yourself writing the same
boiler-plate code over and over again.

Themify try to centralize it by using definitions stored in plist files. So, you
can change the entire look of your app from a central point, without having to
edit any interface files anymore.

# Principles

Themify does not rely on method swizzling like other libraries do. It uses the
default way to customize apps by using appearance proxies. This library get the
class name from your configuration, locate it on the run-time and do its magic.

It is designed to be small, fast and easy to use.

Your application don´t have access to the theme structure. It is maintained
internally. _Themify_ main class is just a _theme manager_, loading and applying
it when requested. Since a theme is a shared state of any application, _Themify_
class was implemented as a singleton.

# Theme file layout

The theme file is a simple plist. However, this plist must have the following format:

- Array (top-level)
  - Dictionary
    - name: String - Theme name
    - elements: Array (element definitions)
      - Dictionary (element definition)
        - element: String - Name of the element (i.e., _UILabel_)
        - attribute: String - Attribute to customize. (the key is the attribute, and the value, what is being customized

See the file _TestTheme.plist_ for a practical example.

# Usage

Usage is quite simple. Themes are identified by meaningful names in plist
file. Here is a plist example:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
	<dict>
		<key>name</key>
		<string>Default</string>
		<key>elements</key>
		<array>
			<dict>
				<key>element</key>
				<string>UITabBar</string>
				<key>tintColor</key>
				<string>#FF8000</string>
			</dict>
			<dict>
				<key>element</key>
				<string>UINavigationBar</string>
				<key>tintColor</key>
				<string>#FF8000</string>
			</dict>
		</array>
	</dict>
</array>
</plist>
```

Each plist contains several themes. That's why it holds an array as top-level
element. So, for this example, here is how to load this theme, in swift:

```swift
import Themify

if let themeURL = Bundle.main.url(forResource: "theme", withExtension: "plist") {
    do {
        try Themify.shared.loadThemes(from: themeURL)
        try Themify.shared.applyTheme(themeName: "Default")
    } catch {
        // Catch exception here.
    }
}
```

# License

This library is released under [MIT License](LICENSE).

[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license
[travis-build-url]:https://travis-ci.org/nineteen-apps/themify.svg?branch=master
[travis-url]: https://travis-ci.org/nineteen-apps/themify
