# Animation Recorder

A tool that Recording any animation of AnimationPlayer


**⚠ Note:** Use Godot Engine v3.4 to avoid this bug [#7](https://github.com/AhmedElTabarani/AnimationRecorder/issues/7)

## How to use

https://user-images.githubusercontent.com/69223584/135526555-21753c0f-1f66-4e6a-8604-9d070de3945f.mp4

## Installation

- Download this project as a ZIP
- Extract it :)
- Inside the project folder you will find a folder called `AnimationRecorder` 
- Move the `AnimationRecorder` folder inside your project, you can add it inside `addons/` folder if you want.

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
  - The folder that will store the images
  - If you keep it empty, the images will be stored in `res://AnimRecResult` folder 
- Save Option
  - You can save the record as `Split Images` or as `Sprite Sheet`
  - If you select `Sprite Sheet`, The `Number of Columns` property will be appear
    - Number of Columns
      - Set number of columns of the sprite sheet
      - Number of Rows will be calculated as : FPS * Length of Animation Per Second 
- Exit After Finish
   - If is set to true, the program will be terminated itself after the recording finish
   - If is set to false, the program will be still opening and be idling


[MIT License](LICENSE)
