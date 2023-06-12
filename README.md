# Qt auto installer

This project allows you to perform an automated installation of the Qt framework using the Qt online installer.

## Dependencies
### macos and linux
- wget

### windows
- curl


## How to use
- Create a **config.js** file in **js** folder. Accepted configuration variables are provided in the **config.js.template** file.
- Run the **install-qt** script according to your platform:
    - macos/install-qt.sh for macos.
    - win/install-qt.bat for windows.
    - linux/install-qt.sh for windows.


## Examples
Here is an example for the installation of **Qt 5.15.2**.
### macos
**js/config.js**
```
...

const COMPONENTS = [
    'qt.qt5.5152.clang_64',
    'qt.qt5.5152.debug_info',
    'qt.tools.qtcreator',
    'qt.tools.qtcreator_gui',
    'qt.tools.cmake',
    'qt.tools.ninja'
];

const QT_INSTALLATION_DIR = installer.value('HomeDir') + '/Qt'
const RUN_QT_CREATOR = true;
```
```
$ ./macos/install-qt.sh
```

### windows
**js/config.js**
```
...

const COMPONENTS = [
    'qt.qt5.5152.msvc2019_64',
    'qt.qt5.5152.debug_info',
    'qt.tools.qtcreator',
    'qt.tools.qtcreator_gui',
    'qt.tools.cmake',
    'qt.tools.ninja'
];

const QT_INSTALLATION_DIR = 'C:\\Qt'
const RUN_QT_CREATOR = false;
```
```
C:\%userprofile%> win\install-qt.bat
```

### linux
**js/config.js**
```
...

const COMPONENTS = [
    'qt.qt5.5152.gcc_64',
    'qt.qt5.5152.debug_info',
    'qt.tools.qtcreator',
    'qt.tools.qtcreator_gui',
    'qt.tools.cmake',
    'qt.tools.ninja'
];

const QT_INSTALLATION_DIR = installer.value('HomeDir') + '/Qt'
const RUN_QT_CREATOR = false;
```
```
$ ./linux/install-qt.sh
```