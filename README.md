README.md text for github

# Godot_WaveFunctionCollapse
A port of the Wave Function Collapse by Maxim Gumin algorithm to Godot.

## About
This plugin is a slightly-modified version of the Wave Function Collapse (WFC) algorithm originally written by Maxim Gumin. I only modified it slightly to get it to work with Godot, and use Godot-based images rather than those used by C# and .NET or whatnot.

## Getting Started

### Requirements
Godot 3.x

### Installation
After downloading, move the folder `addons/godot_wfc_mono` to your project folder.

### Example Project
In the given project, the WFC algorithm is used to generate a 48 x 48 image based on some orange bricks.

### Usage

Instead of using an XML file, Models are made by creating a new instance of the appropriate script.

**Note:** As this uses C# files, upon installing the add-on, as Godot tries to load the file, you will get an error about "`Unable to load addon script from path 'res://addons/godot_wfc_mono/godot_wfc_mono.cs'`". You must first build the project, then head to the "Plugins" tab under "Project Settings..." to re-enable the add-on; it should work then.

#### Overlapping Model

The **Overlapping Model** takes a Godot Image (gotten by calling `*.get_data()` on any Godot Image sub-class) and slices it into multiple N-wide tiles. Each tile is given adjacency rules based on the passed parameters. Multiple "stacks" of these image slices are placed across the new image, with one chosen to be collapsed at random. Nearby cell stacks have tiles removed that would invalidate the adjacency rules. Over time, depending on the heuristic used, the output image is formed.

Unlike the original algorithm software, this model does *not* use an `*.xml` file.

To create a new instance of an **Overlapping Model**, load the `OverlappingModel.cs` script and call `*.new(...)`. It takes the following parameters:
- `sourceImage`
  - A Godot image (as gotten by calling `Image.get_data()`).
- `N`
  - An integer defining the side-length of each "slice" of the image. Usually `3` works for most images.
- `width`
  - An integer defining the pixel width for the image being created.
- `height`
  - An integer defining the pixel height for the image being created.
- `periodicInput`
  - A boolean dictating whether the **source** image being used as input is tileable.
    - If `true`, the input image's bottom and top are considered as "connected", and can appear next to each other in the output image.
    - `false` does otherwise.
- `periodic`
  - A boolean dictating whether the **output** image should be tileable.
    - `true` makes the output tileable; `false` otherwise.
- `symmetry`
  - An integer (ranging in value from `0` to `8`; anything above or below is truncated) representing which symmetries of the input image should be used.
- `ground`
  - An integer representing where the "ground" is in the output image. Passing `0` has there be no "ground".
  - This can be useful for vertical-style 2D maps, where a definitive ground/sky boundary is wanted. Experimentation will help find the best results.
- `heuristic`
  - (In GDScript, this is an integer; in C#, it is of the enumeration `Heuristic`)
  - An integer or enum value that determines the type of heuristic to use in the wave function collapsing.
    - `Entropy` (`0`) uses a numerical value called "entropy" to determine how "chaotic" a cell is. The algorithm will choose cells that have lower entropy values (less chaos) and _collapse_ them to a single value; this change is then propogated outwards, and all neighboring cells that would be affected have the now-illegal cell values removed from their pool of choices, reducing their entropy.
    - `MRV` (`1`) uses the remaining possible values for that cell to determine which value should be chosen, rather than a calculated entropy as used by the `Entropy` heuristic.
    - `Scanline` (`2`) iterates through the wave and sees if the the value it iterates to is a valid option.

#### Simple Tiled Model

The **Simple Tiled Model** is an alternative to the Overlapping Model wherein you provide the system with a series of tiles and the adjacency rules -- the rules that tell the algorithm what tiles can be adjacent to one another. This Model requires there be a folder in the project root directory named "`samples`" exactly as written in the quotes. Within there should be sub-folders, the names of which are referenced when creating the `SimpleTiledModel`. Within the named sub-folder should be the images you wish to use in the Model and a file named "`data.xml`"; this file should define the tiles and their adjacency rules.

A note to those who come after: while I have modified some of the algorithms to work with Godot images and data-types, I am not too knowledgeable on the entirety of how data is used. 

To create a new instance of a **Simple Tiled Model**, load the `SimpleTiledModel.cs` script and call `*.new(...)`. It takes the following parameters:
- `name`
  - A string that is the name of the folder where the images and `data.xml` file can be found.
- `subsetName`
  - A string that denotes a sub-set.
- `width`
  - An integer that defines the pixel width of the output image.
- `height`
  - An integer that defines the pixel height of the output image.
- `periodic`
  - A boolean that dictates if the **output** image should be tileable.
- `blackBackground`
  - A boolean that will fill the image first with black. This could be used if the images used by the Model have transparency and you do not wish to retain the transparency.
- `heuristic`
  - The heuristic to use to collapse the wave function. This is the same as the Overlapping Model's heuristic.

The `data.xml` file is based on the XML files used by the Simple Tiled Model script originally written by Gumin. The script wasn't changed too much when I ported it over. I recommend reading through Gumin's repository for the WFC algorithm if you need an idea of how to structure the XML file. [Here is a link to Gumin's repository](https://github.com/mxgmn/WaveFunctionCollapse).

Just remember: each folder should be uniquely named and possess a file called "`data.xml`" that has the data.

It is possible to add other images, and have those be used to generate larger images as well; except for the Simple Tiled Model, the plugin does not use XML files like the original algorithm-program does, but rather the GDScript `Model.new(...)` system.
