%Read the image
img = imread('course1image.jpg');

%height and width
[r, c] = size(img);
Third = floor(r/3);

%extracting the channel
B = img(1:(Third), :);
G = img((Third+1):(2*Third), :);
R = img((2*Third+1):(3*Third), :);

%getting the center of G
c_x = (341/2-25);
c_y = (400/2-25);
ref_img_region = double(G(c_x:c_x + 50, c_y:c_y + 50));

%aligning red
red_offset = offset(double(R(c_x:c_x + 50, c_y:c_y + 50)), ref_img_region);
shifted_red = circshift(R, red_offset);

%aligning blue
blue_offset = offset(double(B(c_x:c_x + 50, c_y:c_y + 50)), ref_img_region);
shifted_blue = circshift(B, blue_offset);

%combining RGB channles
ColorImg_aligned = cat(3, shifted_red, G, shifted_blue);
imshow(ColorImg_aligned);

% Find the minimun offset by ssd
function [output] = offset(img1, img2)
    MIN = inf; 
    for x = -10:10
        for y = -10:10
            temp = circshift(img1, [x, y]);
            ssd = sum((img2 - temp).^2, 'all');
            if ssd < MIN
                MIN = ssd;
                output = [x, y];
            end
        end
    end
end
