# Portfolio
=======

Gallery for personal art work.
Build on top of  jekyll template [Fry](https://github.com/lilykonings/fry).
Supports video, and categorizing work.


Main purpose: Show daily work in an easy-way to mantain up to date.

#### Adding new entry

Useful resource for editing screen capture:

`ffmpeg -i input.mp4 -ss 00:01:10 -t 00:01:05 -c:v copy -c:a copy output.mp4`

Adding entry:

```
    bash ./create-entry.sh 
        -from       {local_directory_of_files}
        -title      {title}
        -detail     {detail_shown_on_hoover} 
        -description {description of work}
        --vid //flag for adding videos supports mp4/matroska
        --img //flag for adding imgs
        
```

