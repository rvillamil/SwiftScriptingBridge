# Swift Scripting Bridge

## Description

Tools's set to generate swift frameworks for using scripting bridge. Thank's to https://github.com/tingraldi/SwiftScripting . I'am only a copy-paste man ;)

## Usage

Note that the sbhc.py script leverages the Python bindings for libclang. You must install these bindings before running the script. You'll also need to install the Xcode command line tools 

First, you need install python 'clang' module.

```bash
$sudo easy_install clang
```

Now you have to run this shell script, for building and installing scripting build frameworks in /Library/Frameworks

```bash
./install.sh
```

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/rvillamil/iTunesQuickRatingBar/tags).

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
