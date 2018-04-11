MockupVisualEditor originally was created by [Josh Tynjala](https://www.patreon.com/josht/) in [Apache Flex](https://flex.apache.org/) as Web and Desktop application. 
Visual Editor can help you to develop the prototype of your user interface and export as Apache Flex Desktop project.

## Installation

Visual Editor was adoped by [Moonshine IDE](https://github.com/prominic/Moonshine-IDE/) as ActionScript library project. 
Instruction allows you to build project to *.swc which can be used in Moonshine IDE.

### Prerequisites
Visual Editor is built with [Apache Flex® SDK 4.16.1](https://flex.apache.org/installer.html), using [Adobe AIR and Flash Player 28.0](https://helpx.adobe.com/flash-player/release-note/fp_28_air_28_release_notes.html).

### Moonshine swc library

1. Download and install [Apache Ant®](https://ant.apache.org/)
2. Setup environment variable `FLEX_HOME` or add path to the Apache Flex SDK in build.xml -> [here](https://github.com/prominic/MockupVisualEditor/blob/5922c8290a7d780e27f2cda4aa1ec15729d192f1/build.xml#L4)
3. Uncomment [line](https://github.com/prominic/MockupVisualEditor/blob/5922c8290a7d780e27f2cda4aa1ec15729d192f1/build.xml#L7) and set `MOONSHINE_LIBS_PATH` to folder libs `Moonshine-IDE\ide\MoonshineDESKTOPevolved\libs\`
4. Make sure that constant [CONFIG::MOONSHINE](https://github.com/prominic/MockupVisualEditor/blob/5922c8290a7d780e27f2cda4aa1ec15729d192f1/compile-config.xml#L5) is set to true.
5. If you would like to have debuggable swc please set [IsDebug](https://github.com/prominic/MockupVisualEditor/blob/5922c8290a7d780e27f2cda4aa1ec15729d192f1/build.xml#L9) variable to true
6. Run in command line `ant`
