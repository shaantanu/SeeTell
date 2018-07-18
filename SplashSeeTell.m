fig = figure('Visible','off','MenuBar','none','NumberTitle','off',...
   'DockControls','off');

% put an axes in it
imageAxes = axes('Parent',fig,'Visible','on');

% put the image in it
ih = imshow('splash.png','Parent',imageAxes);

% set the figure1 size to be just big enough for the image, and centered at
% the center of the screen
imxpos = get(ih,'XData');
imypos = get(ih,'YData');
set(imageAxes,'Unit','Normalized','Position',[0,0,1,1]);
figpos = get(fig,'Position');
figpos(3:4) = [imxpos(2) imypos(2)];
set(fig,'Position',figpos);
movegui(fig,'center')

% make the figure1 visible
set(fig,'Visible','on');
pause(3);
close(fig);
SeeTell;