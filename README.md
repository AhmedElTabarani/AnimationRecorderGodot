# Animation Recorder

A tool that Recording any animation of AnimationPlayer

## How to use

https://user-images.githubusercontent.com/69223584/135526555-21753c0f-1f66-4e6a-8604-9d070de3945f.mp4

## Installation

You can download this project as a ZIP, then extract it, inside the project folder you will find a folder called `AnimationRecorder` that contain `Record` scene and its script, move the `AnimationRecorder` folder inside your project, you can add it inside `addons/` folder if you want.

## Properties

After adding the `Record.tscn` in your scene,
select the size of the screen you want to record, then change the properties

- Fps
  - You can determine the FPS as you want
- Animation Player Path
  - The path of the AnimationPlayer node
  - If you select a wrong path or a wrong node, you will get some nice errors :)  
- Animation Name
  - The name of the animation you want to record
- Result Folder
  - The folder that will store the images,
  - If you keep it empty, the images will be stored in `res://` 
- Save Option
  - You can save the record as split images or as sprite sheet 
- Exit After Finish
   - If is set to true, the program will be terminated itself after the recording finish `(Maybe cause some problems)`
   - If is set to false, the program will be still opening and be idling `(Recommended)`

![](https://user-images.githubusercontent.com/69223584/135724686-01cbc6a0-366e-4cc1-9a7b-f215903abe6f.png)


[MIT License](LICENSE)
