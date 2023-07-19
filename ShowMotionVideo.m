  
function ShowMotionVideo(filename)

if isempty(filename)
    filename = 'ares_puff.MP4';
end
vidObj = VideoReader(filename);
 
% Specify that reading should start at 0.5 seconds from the
% beginning.
vidObj.CurrentTime = 0.5;
 
% Create an axes
currAxes = axes;

% Get the first video frame
initFrame = readFrame(vidObj);
colormap('gray');
currAxes.Visible = 'off';   
image(initFrame, 'Parent', currAxes);

%**** allow user to resize graph window
input('Resize window and press return to play');

% Read video frames until available
fcnt = 1;
while hasFrame(vidObj)
    vidFrame = readFrame(vidObj);
    diffFrame = (vidFrame - initFrame).^2;
    meandiff =  mean(diffFrame,3);
    
    image(meandiff, 'Parent', currAxes);
    colormap('gray');
    currAxes.Visible = 'off';
    pause(1/vidObj.FrameRate);
    disp(sprintf('Frame %d of %d',fcnt,vidObj.NumFrames));
    fcnt = fcnt + 1;
    initFrame = vidFrame;
end
 
return;

   