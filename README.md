# Animation Recorder

A tool that Recording any animation of AnimationPlayer

## How to use

https://user-images.githubusercontent.com/69223584/135526555-21753c0f-1f66-4e6a-8604-9d070de3945f.mp4

## Installation

You can download this project as a ZIP, then extract it, inside the project folder you will find a folder called `AnimationRecorder` that contain `Record` scene and its script, move the `AnimationRecorder` folder inside your project, you can add it inside `addons/` folder if you want.

## Properties

After adding the `Record.tscn` in your scene

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
- Exit After Finish
   - If is set to true, the program will be terminated itself after the recording finish
   - If is set to false, the program will be still opening and be idling

![](https://user-images.githubusercontent.com/69223584/135526890-db20f6fc-5cfd-47cd-afae-db91a3b8ecda.png)

[MIT License](LICENSE)