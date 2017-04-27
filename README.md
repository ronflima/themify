# Themify
[![Mit License][mit-badge]][mit-url]

## What is Themify?

Themify is a small library that manages color themes using appearance
proxies. The ideia is to create a standardized, centralized and simple way to
create color themes that are applied to your app.

## What problem does it try to solve?

Creating color themes for an app is a boring task. You need to set color
properties over and over again, using storyboards or xib files. For large apps,
changing your color theme is hard and a no-brainer task.

Themify try to centralize it by using definitions stored in files or hard-coded
in your code. So, you can change the entire look of your app from a central
point, without having to edit any interface files anymore.

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

# In-memory layout of raw themes

The in-memory layout follows exactly the file layout in order to describe a
theme in memory.

# License

This library is released under [MIT License](LICENSE).

[mit-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat
[mit-url]: https://tldrlegal.com/license/mit-license
