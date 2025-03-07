# Serial Port Plotter

This is a Windows application that displays real time data from serial port. The application is 32-bit and built with Qt and QCustomPlot library.

## Features

- No axes limit: An unknown/new channel data create a new graph and uses it (palette of 14 cyclic colors)
- No data point limit: All received data is kept so user can explore old data
- No baud rate limit: Tested up to 912600 bps
- Zooming and dragging using the mouse (wheel or click, restricted to X axis only)
- Moving around the plot displays the X and Y values of the graph in the status bar
- Channel's name legend (double-click to modify)
- Channel selection (click on legend's text)
- Supports positive and negative integers and floats
- Exports to PNG
- Exports to CSV
- Autoscale to visible graph
- Regular expression to extract numeric data from serial stream
- Send command field to send serial commands to connected device

## Screenshot

(Needs update)
![Serial Port Plotter screenshot](res/screen_0.png)

## How to use the application

Just send your integer data over the serial port. The application does not expect a certain format. The input data can be extracted with a regular expression from the serial data stream.
For example to detect a set of 2 decimal numbers we can use the regex: `(\d+.\d*)[^1-9]*?(\d+.\d*)[^1-9]*?\n` 
- This check for a number `(\d+.\d*)` (possibly containing a decimal dot),
- a separator string `[^1-9]*?` that can be anything except a number (space for example)
- and the second number `(\d+.\d*)`
- than any characters except numbers + a linefeed `[^1-9]*?\n`

To recognized number always use `()` groupings in regex. The software extracts all first layer groupings and uses those as input for plotting. (So do not use nested grouping).
If data is recognized correctly it should show up as numbers separated by a space on the **Filtered data view**. It is recommended to check for a line feed as an end character for the
regex in order to only find matches that are on the same line. It is suggested to paste a complete regular expression into the regex field and not edit in in-situ in order to avoid strange behaviour.

The Help button displays usage instructions.

Use the mouse wheel over controls to change its values and use it over plot area to zoom.

When stopped/paused, plot area can be dragged.

To enable the file saving, click on the document button. The data is saved when it comes in on serial so any data that came in before pressing the document icon is not saveable to a .csv file. (Only as a .png)

Double click on a channel in the Graph Control panel to hide/show a specific channel.

It is also possible to send serial commands to the device we are connected to. Just type the desired command into the **Serial command** field and press enter to send it.

![File Save Button](res/screen_1.png)

## Send data over the serial port from device

```c
/* Example: Plot two values */
printf ("$%d %d;", data1, data2);
```

Depending on how much data you want to display, you can adjust the number of data points. For example, if you send data from the serial port of the mbed every 10 ms (100 Hz) and the plotter is set to display 500 points, it will contain information for 5 seconds of data.

The software supports integer and decimal numbers ( float/double )

## Source

Source and .pro file of the Qt Project are available. A standalone Windows .exe is included for the people who do not want to build the source. Search for it at [releases](https://github.com/VitanovG/Regex_Serial_Plotter/releases/new)

## Build on Windows

- Install [Innosetup](https://jrsoftware.org/isdl.php) and add to Path
- Install [Qt 5.12.0](https://download.qt.io/archive/qt/5.12/5.12.0/)
- Add Qt/bin to path for the compiler in use (MingW)
- git clone https://github.com/ColinDuquesnoy/QDarkStyleSheet into "Regex_Serial_Plotter/res/qdark_stylesheet"
- Open project in Qt creator and Build Release
- Find build folder and copy "release" dir to "Regex_Serial_Plotter/build"
- Run make_installer.bat (this will package the .dlls into an installer at Regex_Serial_Plotter/build/installer/*.exe)
- Install the application

## Credits

- [Serial Port Plotter at mbed forums](https://developer.mbed.org/users/borislav/notebook/serial-port-plotter/) by [Borislav K](https://developer.mbed.org/users/borislav/)
- [Line Icon Set](http://www.flaticon.com/packs/line-icon-set) by [Situ Herrera](http://www.flaticon.com/authors/situ-herrera) icon pack
- [Lynny](http://www.1001freedownloads.com/free-vector/lynny-icons-full) icon pack
- [Changelog](http://keepachangelog.com/)
- Base of this software by [CieNTi](https://github.com/CieNTi)
- CSV export by [HackInventOrg](https://github.com/HackInventOrg)
- Regex and serial command field implemented by [VitanovG](https://github.com/VitanovG)

## Changelog

All notable changes to this project will be documented below this line.
This project adheres to [Semantic Versioning](http://semver.org/).

## [1.5.0] - 2025-03-07

### Info

- Build with QT 5.12.0
- Updated helpwindow
- Added minimum size requirements for most of the buttons

### Added

- Added file dialog to buttons that save data in .csv and .png

## [1.4.0] - 2025-03-03

### Info

- Build with QT 5.12.0
- Reworked serial stream readin to prevent cutting up lines in Incoming Data Field

### Added

- Regex field to enable reading serial data in any format
- Serial command field for sending serial commands to connected device
- Instructions on how to build

## [1.3.0] - 2018-08-01

### Info

- Built with QT 5.11.1
- QT libraries updated and new plot features implemented
- Beginning of version 1.3

### Added

- COM port refresh button to update the list
- Channel visibility control added to turn off unwanted channel
- Autoscale button for Y axis will autoscale to the highest value + 10%
- Save to CSV support

### Changed

- qDarkStyle updated to 2.5.4
- qCustomplot updated 2.0.1

### Bugfix

- Axis rename dialog gets focus when popup occurs

## [1.2.2] - 2018-07-26

### Info

- Project forked from HackInvent since 1.2.1

### Added

- UART debug textBox
- Textbox control ( toggle visible and toggle data filter )

## [1.2.1] - 2017-09-24

### Fixed

- Support for float/double has been added
- Linux build fails because no `serial_port_plotter_res.o` file was found (Issue #4)

## [1.2.0] - 2016-08-28

### Added

- Negative numbers support ([cap we](https://developer.mbed.org/users/capwe/) FIX at [mbed forums](https://developer.mbed.org/comments/perm/22672/))
- Support for high baud rates (tested up to 912600 bps)

## [1.1.0] - 2016-08-28

### Added

- Original qdarkstyle resources (icons are working now)
- Manifest and all Windows related/recommended configs
- *Line Icon Set* icons in 3 colors
- *Lynny* icons in 3 colors
- Inno Setup file with auto-pack .bat file (installer tested on WinXP-32b and Win10-64b)
- Play/Pause/Stop, Clear and Help toolbar buttons

### Changed

- Resources structure
- Updated qcustomplot to v1.3.2
- Menubar is replaced by icon toolbar for usability
- [WiP] mainwindow.cpp doxygen friendly comments

### Removed

- Control over number of points
- Delete previous graph data
- *Connect* and *Start/Stop plot* buttons

## [1.0.0] - 2014-08-31

### Added

- Original [Borislav Kereziev](mailto:b.kereziev@gmail.com) work commit [source](https://developer.mbed.org/users/borislav/notebook/serial-port-plotter/)


## To-Do

- Port list refresh
- Fill baud automatically and allow custom by textbox (when COM ui)
- PNG *WITH* transparency
- Separate `receive_data` from `process_data` to allow non-throttled operations

[1.5.0]: https://github.com/VitanovG/Regex_Serial_Plotter/releases/tag/v1.5.0
[1.4.0]: https://github.com/VitanovG/Regex_Serial_Plotter/releases/tag/v1.4.0
[1.3.0]: https://github.com/Eriobis/serial_port_plotter/releases/tag/v1.3.0
[1.2.2]: https://github.com/Eriobis/serial_port_plotter/releases/tag/v1.2.2
[1.2.0]: https://github.com/CieNTi/serial_port_plotter/releases/tag/v1.2.0
[1.1.0]: https://github.com/CieNTi/serial_port_plotter/releases/tag/v1.1.0
[1.0.0]: https://github.com/CieNTi/serial_port_plotter/releases/tag/v1.0.0
