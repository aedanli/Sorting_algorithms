function sort_selection(do_sort,random_matrix)
%% Aedan Yue Li
% Memory & Perception Lab, 
% University of Toronto
% April 2017
%

%% This code visualizes different sorting algorithms
% current do_sort arguments:

% 'bubble_sort': https://en.wikipedia.org/wiki/Bubble_sort
% 'brick_sort': https://en.wikipedia.org/wiki/Odd%E2%80%93even_sort
% 'insertion_sort': https://en.wikipedia.org/wiki/Insertion_sort
% 'selection_sort': https://en.wikipedia.org/wiki/Selection_sort

% random_matrix should be specified as 1 for a default randomized colour matrix, 0
% for your own image. If you select 0, the image should be in the same directory as this
% file. Play with the setting values and change the variable picture_name
% to get a size that works

%% settings
own_image_factor = [0.025]; % play around with this value if inserting own images
size_of_image = [15]; % size of the randomized colour matrix
if random_matrix == 0
picture_name = 'picture.jpg'; % define the name of your picture
end

%% Either random matrix or input image
% start code
% randomly generate image pixels in RGB
if random_matrix == 1
    image_RGB = generate_random_matrix(size_of_image); 
    display_img(image_RGB);
        % xy lengths
        size_x = size_of_image;
        size_y = size_of_image;  
elseif random_matrix == 0
    image_RGB = double(imread(picture_name));
    image_RGB = imresize(image_RGB, own_image_factor);
    display_img(image_RGB);
        % xy lengths
        size_x = length(image_RGB(:,1,1));
        size_y = length(image_RGB(1,:,1));       
end

%% set RGB values from image
% first reshape to vector, then transform to brightness values
[vector_R, vector_G, vector_B] = convert_img_to_RGBvector(image_RGB);
brightness_vector = brightness_fun(vector_R, vector_G, vector_B);
length_vector = length(brightness_vector);

%% pick a sort
if strcmp(do_sort, 'bubble_sort') == 1
    bubble_sort(size_x,size_y,brightness_vector, vector_R, vector_G, vector_B)
elseif strcmp(do_sort, 'selection_sort') == 1
    selection_sort(size_x, size_y, brightness_vector, length_vector, vector_R, vector_G, vector_B)
elseif strcmp(do_sort,'insertion_sort') == 1
    insertion_sort(size_x, size_y, length_vector, brightness_vector, vector_R, vector_G, vector_B)
elseif strcmp(do_sort,'brick_sort') == 1
    odd_even_bubble_sort(size_x, size_y, length_vector, brightness_vector, vector_R, vector_G, vector_B)
end

%% define brightness equation as how humans perceive colour
function [brightness_vector] = brightness_fun(vector_R, vector_G, vector_B)
    brightness_vector = sqrt(0.299*(vector_R).^2 + 0.587*(vector_G).^2 + 0.114*(vector_B).^2);
end
%% convert img to vector
function [vector_R, vector_G, vector_B] = convert_img_to_RGBvector(image_RGB)
    matrix_R = image_RGB(:,:,1);
    matrix_G = image_RGB(:,:,2);
    matrix_B = image_RGB(:,:,3);
    vector_R = matrix_R(:)';
    vector_G = matrix_G(:)';
    vector_B = matrix_B(:)';
end
%% display first image
function display_img(image_RGB)
    base_RGB = uint8(image_RGB);
    image(base_RGB)
    % faster plot updating
    set(gca,'xtick',[],'ytick',[])
    imageHandle = get(gca,'Children');
    set(imageHandle,'CData',base_RGB)
    if random_matrix == 1
    axis square
    end
    drawnow;
end
%% display sorted image
function display_new_RGB(vector_R, vector_G, vector_B, size_x, size_y)
    matrix_R = reshape(vector_R',[size_x, size_y]);
    matrix_G = reshape(vector_G',[size_x, size_y]);
    matrix_B = reshape(vector_B',[size_x, size_y]);
    new_image_RGB(:,:,1) = matrix_R;
    new_image_RGB(:,:,2) = matrix_G;
    new_image_RGB(:,:,3) = matrix_B;
    new_RGB = uint8(new_image_RGB);
    image(new_RGB);
    % faster plot updating
    set(gca,'xtick',[],'ytick',[])
    imageHandle = get(gca,'Children');
    set(imageHandle,'CData',new_RGB)
    if random_matrix == 1
    axis square
    end
    drawnow;
end
%% generate starting matrix
function [image_RGB] = generate_random_matrix(size_of_image)
    image_RGB = NaN(size_of_image,size_of_image,3);
    for height = 1:size_of_image
        for width = 1:size_of_image
            for RGB = 1:3
            image_RGB(height,width,RGB) = randperm(255,1);
            end
        end
    end
end

%% straight select sort
function selection_sort(size_x, size_y, brightness_vector, length_vector, vector_R, vector_G, vector_B)
tic
for ii = 1:size_x*size_y
    index = find(brightness_vector == min(brightness_vector(:,ii:length_vector)));

        % swap using straight selection sort algorithm
        vector_R([index ii]) = vector_R([ii index]);
        vector_G([index ii]) = vector_G([ii index]);
        vector_B([index ii]) = vector_B([ii index]);
                        
        display_new_RGB(vector_R, vector_G, vector_B, size_x, size_y); % display new result
             
        % if sorting by brightness, recalculate brightness vector from
        % shuffled RGB vectors
        brightness_vector = brightness_fun(vector_R, vector_G, vector_B);   
end
toc
end

%% brick sort
% do bubble sort on even indices, then odd indices until sorted
function odd_even_bubble_sort(size_x, size_y, length_vector, brightness_vector, vector_R, vector_G, vector_B)
tic
    list_vector = 1:length_vector;
    list_even = list_vector(mod(list_vector,2)==0);
    list_odd = list_vector(mod(list_vector,2)~=0);

    swap_counter = 1;
    while swap_counter > 0
        idx_counter = 0;
    
    for ii = 1:length(list_even)
        index = brightness_vector;
 
        % do for all, except last pixel
        if list_even(ii) < length_vector
            compare_index = brightness_vector(:,list_even(ii)+1);
        
            % swap using bubble sort algorithm
            if index(:,list_even(ii)) > compare_index
            % do swap
            vector_R([list_even(ii) list_even(ii)+1]) = vector_R([list_even(ii)+1 list_even(ii)]);
            vector_G([list_even(ii) list_even(ii)+1]) = vector_G([list_even(ii)+1 list_even(ii)]);
            vector_B([list_even(ii) list_even(ii)+1]) = vector_B([list_even(ii)+1 list_even(ii)]);
            
            display_new_RGB(vector_R, vector_G, vector_B, size_x, size_y); % display new result
            idx_counter = idx_counter+1; % count swaps
            
            % if sorting by brightness, recalculate brightness vector from
            % shuffled RGB vectors
            brightness_vector = brightness_fun(vector_R, vector_G, vector_B);   
            end     
        end
    end
    for ii = 1:length(list_odd)
        index = brightness_vector;
 
        % do for all, except last pixel
        if list_odd(ii) < length_vector
            compare_index = brightness_vector(:,list_odd(ii)+1);
        
            % swap using bubble sort algorithm
            if index(:,list_odd(ii)) > compare_index
            % do swap
            vector_R([list_odd(ii) list_odd(ii)+1]) = vector_R([list_odd(ii)+1 list_odd(ii)]);
            vector_G([list_odd(ii) list_odd(ii)+1]) = vector_G([list_odd(ii)+1 list_odd(ii)]);
            vector_B([list_odd(ii) list_odd(ii)+1]) = vector_B([list_odd(ii)+1 list_odd(ii)]);
            
            display_new_RGB(vector_R, vector_G, vector_B, size_x, size_y); % display new result
            idx_counter = idx_counter+1; % count swaps
            
            % if sorting by brightness, recalculate brightness vector from
            % shuffled RGB vectors
            brightness_vector = brightness_fun(vector_R, vector_G, vector_B);   
            end     
        end
    end
    % if no more swaps, then end bubble sort algorithms
        if idx_counter == 0
            swap_counter = 0;
        end
    end
toc    
end

%% bubble sort
% compare each item to right neighbour, if right is smaller, swap; seperately for each axis
function bubble_sort(size_x,size_y,brightness_vector, vector_R, vector_G, vector_B)
    tic
        swap_counter = 1;
    while swap_counter > 0
        idx_counter = 0;
    
    for ii = 1:size_x*size_y
        index = brightness_vector;
 
        % do for all, except last pixel
        if ii < size_x*size_y
            compare_index = brightness_vector(:,ii+1);
        
            % swap using bubble sort algorithm
            if index(:,ii) > compare_index
            % do swap
            vector_R([ii ii+1]) = vector_R([ii+1 ii]);
            vector_G([ii ii+1]) = vector_G([ii+1 ii]);
            vector_B([ii ii+1]) = vector_B([ii+1 ii]);
            
            display_new_RGB(vector_R, vector_G, vector_B, size_x, size_y); % display new result
            idx_counter = idx_counter+1; % count swaps
            
            % if sorting by brightness, recalculate brightness vector from
            % shuffled RGB vectors
            brightness_vector = brightness_fun(vector_R, vector_G, vector_B);   
            end     
        end
    end
    % if no more swaps, then end bubble sort algorithms
        if idx_counter == 0
            swap_counter = 0;
        end
    end
toc
end

%% insertion sort
function insertion_sort(size_x, size_y, length_vector, brightness_vector, vector_R, vector_G, vector_B)
tic
for ii = 2:length_vector
        index = brightness_vector;
        key = index(:,ii);
        q = ii-1;
        
        R_key = vector_R(:,ii);
        G_key = vector_G(:,ii);
        B_key = vector_B(:,ii);
        
        while q > 0 && index(:,q) > key
            vector_R(:,q+1) = vector_R(:,q);
            vector_G(:,q+1) = vector_G(:,q);
            vector_B(:,q+1) = vector_B(:,q);
                q = q - 1;
            vector_R(:,q+1) = R_key;
            vector_G(:,q+1) = G_key;
            vector_B(:,q+1) = B_key;
            
            display_new_RGB(vector_R, vector_G, vector_B, size_x, size_y); % display new result
            
            % if sorting by brightness, recalculate brightness vector from
            % shuffled RGB vectors
            brightness_vector = brightness_fun(vector_R, vector_G, vector_B);
        end
end
toc
end

end
